class PhotoRandomizer
  attr_reader :album_id, :device_mac_address

  def initialize(album_id, device_mac_address)
    @album_id = album_id
    @device_mac_address = device_mac_address

    Album.find(album_id).devices.where(mac_address: device_mac_address).first_or_create
  end

  def photo
    if device_mac_address && !device_mac_address.blank?
      Album.find(album_id).random_by_device(Device.where(mac_address: device_mac_address).first)
    else
      Album.find(album_id).random
    end
  end
end
