class CollectorWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high", retry: false, :backtrace => true

  def perform(url, access_token_string)
    photos_json = JSON.parse(open(URI.encode(url)).read)
    CollectorWorker.perform_async("#{photos_json["paging"]["next"]}&#{access_token_string}", access_token_string) if photos_json["paging"]["next"]
    create_photos(photos_json)
  end

  private

  def create_photos(hash)
    hash["data"].each do |photo|
      create_photo(open(photo["source"]))
    end
  end

  def create_photo(tempfile)
    photo = Photo.new
    photo.photo = tempfile
    photo.save!
  end
end
