class Photo < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  paginates_per 10
  belongs_to :album
end
