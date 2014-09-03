class AdvertisementRandomizer
  attr_reader :album_id

  def initialize(album_id)
    @album_id = album_id
  end

  def advertisement
    Advertisement.random(album_id)
  end
end
