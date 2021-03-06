class UpdaterWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high", retry: false, :backtrace => true

  def perform(url, access_token_string, album_id)
    photos_json = JSON.parse(open(URI.encode(url)).read)
    update_photos(photos_json, album_id)
  end

  private

  def update_photos(hash, album_id)
    send_notification = false
    hash["data"].each do |photo|
      unless Photo.exists?(:fb_id => photo["id"])
        create_photo(photo, album_id)
        send_notification = true
      end
    end

    album = Album.find(album_id)
    if send_notification && album.android_gcm_api_key && album.show_photos_default
      gcm = GCM.new(album.android_gcm_api_key)
      options = {'data' => {'title' => album.name, 'message' => album.message}, 'collapse_key' => 'updated_state'}
      reg_ids = album.devices.where.not('reg_id' => nil).where(push_notif_enabled: true).map{ |x| x.reg_id }
      gcm.send(reg_ids, options)
    end
  end

  def create_photo(hash, album_id)
    album = Album.find(album_id)
    photo = album.photos.new
    photo.photo = open(hash["source"])
    photo.fb_id = hash["id"]
    photo.text = hash["name"]
    photo.new = true;
    photo.created_at = hash["created_time"]
    photo.show = false unless album.show_photos_default
    photo.save!
  end
end
