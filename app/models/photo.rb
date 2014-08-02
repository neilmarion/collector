class Photo < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  paginates_per 10
  belongs_to :album

  def next
    album.photos.where("created_at < ?", created_at).order("created_at DESC").first
  end

  def prev
    album.photos.where("created_at > ?", created_at).order("created_at DESC").last
  end
end
