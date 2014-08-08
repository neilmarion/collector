require 'rails_helper'

RSpec.describe Collector::API do
  let(:album) { FactoryGirl.create(:album) }
  let(:photo) { FactoryGirl.create(:photo, album: album) }
  before(:each) do
    FactoryGirl.create(:photo, album: album)
    FactoryGirl.create(:photo, album: album)
  end

  it "creates device if 'device' url params is present in the request" do
    mac_address = "AB:CD:EF:GH:IJ"

    get "/v1/show?album_id=#{album.id}&device=#{mac_address}"
    Device.count.should == 1
    Device.where(mac_address: mac_address).count.should == 1
  end

  it "doesn't create device if 'device' url params is not present in the request" do
    get "/v1/show?album_id=#{album.id}"
    Device.count.should == 0
  end
end
