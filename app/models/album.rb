class Album < ActiveRecord::Base
  has_many :photos
  has_many :devices

  def first
    photos.order('created_at DESC').first
  end

  def last
    photos.order('created_at DESC').last
  end

  def random
    photos.order("RANDOM()").first
  end

  def random_by_device(device)
    photos.where("id NOT IN (#{device.read.join(',')})").order("RANDOM()").first || random
  end

  def new
    photos.where(new: true).order('created_at DESC').first
  end

  def new_ids
    photos.where(new: true).order('created_at DESC').all.map(&:id)
  end
end
