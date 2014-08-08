require 'rails_helper'

RSpec.describe Device, :type => :model do
  let(:device) { FactoryGirl.create(:device, mac_address: "123") }

  it "initialize the 'read' data key on create" do
    device.read.should eq []
  end

  it "adds what the device has read" do
    device.has_read(1)
    device.read.should == [1]
  end
end
