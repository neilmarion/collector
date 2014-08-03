class Photo < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  paginates_per 10
  belongs_to :album

  def next
    album.photos.where("created_at < ?", created_at).order("created_at DESC").first || album.first
  end

  def prev
    album.photos.where("created_at > ?", created_at).order("created_at DESC").last || album.last
  end

  def prev_current_next
    prev_photo = self.prev
    next_photo = self.next

    {
      :previous => { :id => prev_photo.id, :photo => prev_photo.photo_url },
      :current => { :id => self.id, :photo => self.photo_url },
      :next => { :id => next_photo.id, :photo => next_photo.photo_url }
    }
  end

  def next_all
    prev_photo = self
    photo = self.next
    next_photo = photo.next

    {
      :previous => { :id => prev_photo.id, :photo => prev_photo.photo_url },
      :current => { :id => photo.id, :photo => photo.photo_url },
      :next => { :id => next_photo.id, :photo => next_photo.photo_url }
    }
  end

  def prev_all
    next_photo = self
    photo = self.prev
    prev_photo = photo.prev

    {
      :previous => { :id => prev_photo.id, :photo => prev_photo.photo_url },
      :current => { :id => photo.id, :photo => photo.photo_url },
      :next => { :id => next_photo.id, :photo => next_photo.photo_url }
    }
  end
end
