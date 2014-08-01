class Collector
  include Sidekiq::Worker
  sidekiq_options queue: "high", retry: false, :backtrace => true

  def perform(url, access_token_string)
    photos_json = JSON.parse(open(URI.encode(url)).read)
    self.perform_async("#{photos_json["paging"]["next"]}&#{access_token_string}")
    self.create_photos(photos_json)
  end

  private

  def self.create_photos(hash)
    hash["data"].each do |photo|
      self.create_photo(open(photo["images"]["source"]))
    end
  end

  def self.create_photo(tempfile)
    photo = Photo.new
    photo.photo = tempfile
    photo.save!
  end
end
