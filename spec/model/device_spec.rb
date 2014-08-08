require 'rails_helper'

RSpec.describe Device, :type => :model do
  it "initialize the 'read' data key on create" do
    device = FactoryGirl.create(:device, mac_address: "123")
    device.read.should eq []
  end
end
