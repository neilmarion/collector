require 'rails_helper'

RSpec.describe PhotoRandomizer do
  let(:album) { FactoryGirl.create(:album) }
  let(:photo) { FactoryGirl.create(:photo, album: album) }
  let(:photo_2) { FactoryGirl.create(:photo, album: album) }
  let(:device) { FactoryGirl.create(:device, album: album) }

  before(:each) do
    photo_2
  end

  it "randomizes photo that hasn't been read by the user" do
    device.has_read(photo.id)
    randomizer = PhotoRandomizer.new(album.id, device.mac_address)
    randomizer.photo.id.should_not eq photo.id
  end

  it "randomizes anyway and clears device's 'read' data if all are read" do
    device.has_read(photo.id)
    device.has_read(photo_2.id)
    randomizer = PhotoRandomizer.new(album.id, device.mac_address)
    randomizer.photo.should_not eq nil
    Device.find(device.id).read.should eq nil
  end
end
