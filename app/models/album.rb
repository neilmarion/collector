class Album < ActiveRecord::Base
  has_many :photos

  def first
    photos.order('created_at DESC').first
  end

  def last
    photos.order('created_at DESC').last
  end

  def random
    photos.find(rand(self.photos.count) + 1)
  end
end
