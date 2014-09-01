class SmallPhotosWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high", retry: true, :backtrace => true

  def perform(url, access_token_string, photo_id)
    photos_json = JSON.parse(open(URI.encode(url)).read)
    photo = Photo.find(photo_id)
    photo.photo = open(photos_json["source"])
    photo.save!
  end
end
