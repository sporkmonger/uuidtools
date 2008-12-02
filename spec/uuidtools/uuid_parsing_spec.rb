require File.join(File.dirname(__FILE__), "../spec_helper.rb")

describe UUID, "when parsing" do
  it "should correctly parse the MAC address from a timestamp version UUID" do
    UUID.timestamp_create.mac_address.should == UUID.mac_address
  end

  it "should correctly parse the variant from a timestamp version UUID" do
    UUID.timestamp_create.variant.should == 0b100
  end

  it "should correctly parse the version from a timestamp version UUID" do
    UUID.timestamp_create.version.should == 1
  end

  it "should correctly parse the timestamp from a timestamp version UUID" do
    UUID.timestamp_create.timestamp.should < Time.now + 1
    UUID.timestamp_create.timestamp.should > Time.now - 1
  end

  it "should not treat a timestamp version UUID as a nil UUID" do
    UUID.timestamp_create.should_not be_nil_uuid
  end

  it "should not treat a timestamp version UUID as a random node UUID" do
    UUID.timestamp_create.should_not be_random_node_id
  end

  it "should treat a timestamp version UUID as a random node UUID " +
      "if there is no MAC address" do
    old_mac_address = UUID.mac_address
    UUID.mac_address = nil
    UUID.timestamp_create.should be_random_node_id
    UUID.mac_address = old_mac_address
  end

  it "should correctly identify the nil UUID" do
    UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]).should be_nil_uuid
  end

  it "should correctly identify timestamp version UUIDs as valid" do
    UUID.timestamp_create.should be_valid
  end

  it "should correctly identify random number version UUIDs as valid" do
    UUID.random_create.should be_valid
  end

  it "should correctly identify SHA1 hash version UUIDs as valid" do
    UUID.sha1_create(
      UUID_URL_NAMESPACE, 'http://sporkmonger.com'
    ).should be_valid
  end

  it "should correctly identify MD5 hash version UUIDs as valid" do
    UUID.md5_create(
      UUID_URL_NAMESPACE, 'http://sporkmonger.com'
    ).should be_valid
  end

  it "should not identify the nil UUID as valid" do
    UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]).should_not be_valid
  end

  it "should allow for sorting of UUID arrays" do
    uuids = []
    1000.times do
      uuids << UUID.timestamp_create
    end
    uuids.sort!
    uuids.first.should < uuids.last
    uuids.last.should > uuids.first
  end

  it "should allow for comparison of UUIDs" do
    UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]).should <
      UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 1])
    UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 1]).should >
      UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])
    UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]).should ==
      UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])
  end

  it "should produce the correct hexdigest for a UUID" do
    UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]).hexdigest.should ==
      "00000000000000000000000000000000"
    UUID.new(1, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]).hexdigest.should ==
      "00000001000000000000000000000000"
    UUID.timestamp_create.hexdigest.size.should == 32
  end

  it "should produce a sane hash value for a UUID" do
    uuid = UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])
    uuid.to_i.should == 0
    uuid.hash.should be_kind_of(Fixnum)
  end

  it "should produce the correct URI for a UUID" do
    UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]).to_uri.should ==
      "urn:uuid:00000000-0000-0000-0000-000000000000"
  end

  it "should correctly test UUID equality" do
    UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]).should be_eql(
      UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])
    )
  end
end
