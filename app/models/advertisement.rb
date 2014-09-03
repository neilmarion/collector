class Advertisement < ActiveRecord::Base
  belongs_to :album
  mount_uploader :photo, PhotoUploader

  def self.random(except_album_id)
    advertisement = Advertisement.where("album_id NOT IN (#{except_album_id})").order("RANDOM()").first
  end
end
