class Album < ActiveRecord::Base
  has_many :photos
  has_many :devices
  has_many :announcements
  has_many :advertisements

  def first
    photos.where(show: true).order('created_at DESC').first
  end

  def last
    photos.where(show: true).order('created_at DESC').last
  end

  def random
    photos.where(show: true).order("RANDOM()").first
  end

  def random_by_device(device)
    if device.read.nil?
      random
    else
      photo = photos.where(show: true).where("id NOT IN (#{device.read})").order("RANDOM()").first
      unless photo.nil?
        photo
      else
        device.update_attributes!(read: nil)
        random
      end
    end
  end

  def new
    photos.where(show: true).where(new: true).order('created_at DESC').first
  end

  def new_ids
    photos.where(show: true).where(new: true).order('created_at DESC').all.map(&:id)
  end
end
