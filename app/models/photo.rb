class Photo < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  paginates_per 10
  belongs_to :album

  def next
    album.photos.where(show: true).where("created_at < ?", created_at).order("created_at DESC").first || album.first
  end

  def prev
    album.photos.where(show: true).where("created_at > ?", created_at).order("created_at DESC").last || album.last
  end

  def prev_current_next(pr)
    prev_photo = self.prev
    next_photo = self.next
    random_photo = pr.photo

    {
      :previous => { :id => prev_photo.id, :photo => prev_photo.photo_url, :small_photo => prev_photo.photo.small.url },
      :current => { :id => self.id, :photo => self.photo_url, :text => self.text, :created_at => self.created_at.to_date.strftime('%a %d %b %Y'), :small_photo => self.photo.small.url },
      :next => { :id => next_photo.id, :photo => next_photo.photo_url, :small_photo => next_photo.photo.small.url },
      :random => { :id => random_photo.id, :photo => random_photo.photo_url, :small_photo => random_photo.photo.small.url }
    }
  end

  def next_all
    prev_photo = self
    photo = self.next
    next_photo = photo.next

    {
      :previous => { :id => prev_photo.id, :photo => prev_photo.photo_url, :small_photo => prev_photo.photo.small.url },
      :current => { :id => photo.id, :photo => photo.photo_url, :small_photo => photo.photo.small.url },
      :next => { :id => next_photo.id, :photo => next_photo.photo_url, :small_photo =>next_photo.photo.small.url }
    }
  end

  def prev_all
    next_photo = self
    photo = self.prev
    prev_photo = photo.prev

    {
      :previous => { :id => prev_photo.id, :photo => prev_photo.photo_url, :small_url => prev_photo.photo.small.url },
      :current => { :id => photo.id, :photo => photo.photo_url, :small_url => photo.photo.small.url },
      :next => { :id => next_photo.id, :photo => next_photo.photo_url, :small_url => next_photo.photo.small.url }
    }
  end
end
