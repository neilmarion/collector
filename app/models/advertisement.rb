class Advertisement < ActiveRecord::Base
  belongs_to :album
  mount_uploader :photo, PhotoUploader
end
