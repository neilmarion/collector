class PhotoRandomizer
  attr_reader :album, :device

  def initialize(album, device)
    @album = album
    @device = device
  end

  def photo
    album.random_by_device(device)
  end
end
