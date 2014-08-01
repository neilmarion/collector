class CollectorWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high", retry: false, :backtrace => true

  def perform(url, access_token_string, album_id)
    photos_json = JSON.parse(open(URI.encode(url)).read)
    CollectorWorker.perform_async("#{photos_json["paging"]["next"]}&#{access_token_string}", access_token_string, album_id) if photos_json["paging"] && photos_json["paging"]["next"]
    create_photos(photos_json, album_id)
  end

  private

  def create_photos(hash, album_id)
    hash["data"].each do |photo|
      create_photo(photo, album_id)
    end
  end

  def create_photo(hash, album_id)
    photo = Album.find(album_id).photos.new
    photo.photo = open(hash["source"])
    photo.fb_id = hash["id"]
    photo.created_at = hash["created_time"]
    photo.save!
  end
end
