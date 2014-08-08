require 'rails_helper'

RSpec.describe PhotoRandomizer do
  let(:album) { FactoryGirl.create(:album) }
  let(:photo) { FactoryGirl.create(:photo, album: album) }
  let(:device) { FactoryGirl.create(:device, album: album) }

  before(:each) do
    FactoryGirl.create(:photo, album: album)
  end

  it "randomizes photo that hasn't been read by the user" do
    device.read << photo.id
    randomizer = PhotoRandomizer.new(album, device)
    randomizer.photo.id.should_not eq photo.id
  end
end
