require File.expand_path("../../spec_helper.rb", __FILE__)

describe UUIDTools::UUID, "when obtaining a MAC address", :unless => UUIDTools::UUID.mac_address.nil? do
  before do
    @mac_address = UUIDTools::UUID.mac_address
  end

  it "should cache the MAC address" do
    @mac_address.object_id.should == UUIDTools::UUID.mac_address.object_id
  end
end
