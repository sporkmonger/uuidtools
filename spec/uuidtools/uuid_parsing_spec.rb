require File.expand_path("../../spec_helper.rb", __FILE__)

describe UUIDTools::UUID, "when parsing" do
  it "should correctly parse the MAC address from a timestamp version UUID" do
    expect(UUIDTools::UUID.timestamp_create.mac_address).to eql(
      UUIDTools::UUID.mac_address
    )
  end

  it "should correctly parse the variant from a timestamp version UUID" do
    expect(UUIDTools::UUID.timestamp_create.variant).to eql(0b100)
  end

  it "should correctly parse the version from a timestamp version UUID" do
    expect(UUIDTools::UUID.timestamp_create.version).to eql(1)
  end

  it "should correctly parse the timestamp from a timestamp version UUID" do
    expect(UUIDTools::UUID.timestamp_create.timestamp).to be < (Time.now + 1)
    expect(UUIDTools::UUID.timestamp_create.timestamp).to be > (Time.now - 1)
  end

  it "should not treat a timestamp version UUID as a nil UUID" do
    expect(UUIDTools::UUID.timestamp_create).not_to be_nil_uuid
  end

  it "should not treat a timestamp version UUID as a random node UUID" do
    expect(UUIDTools::UUID.timestamp_create).not_to be_random_node_id
  end

  it "should treat a timestamp version UUID as a random node UUID " +
      "if there is no MAC address" do
    old_mac_address = UUIDTools::UUID.mac_address
    UUIDTools::UUID.mac_address = nil
    expect(UUIDTools::UUID.timestamp_create).to be_random_node_id
    UUIDTools::UUID.mac_address = old_mac_address
  end

  it "should correctly identify the nil UUID" do
    expect(UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])).to be_nil_uuid
  end

  it "should correctly identify timestamp version UUIDs as valid" do
    expect(UUIDTools::UUID.timestamp_create).to be_valid
  end

  it "should correctly identify random number version UUIDs as valid" do
    expect(UUIDTools::UUID.random_create).to be_valid
  end

  it "should correctly identify SHA1 hash version UUIDs as valid" do
    expect(UUIDTools::UUID.sha1_create(
      UUIDTools::UUID_URL_NAMESPACE, 'http://sporkmonger.com'
    )).to be_valid
  end

  it "should correctly identify MD5 hash version UUIDs as valid" do
    expect(UUIDTools::UUID.md5_create(
      UUIDTools::UUID_URL_NAMESPACE, 'http://sporkmonger.com'
    )).to be_valid
  end

  it "should not identify the nil UUID as valid" do
    expect(UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])).not_to be_valid
  end

  it "should allow for sorting of UUID arrays" do
    uuids = []
    1000.times do
      uuids << UUIDTools::UUID.timestamp_create
    end
    uuids.sort!
    expect(uuids.first).to be < uuids.last
    expect(uuids.last).to be > uuids.first
  end

  it "should allow for comparison of UUIDs" do
    expect(UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])).to be <
      UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 1])
    expect(UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 1])).to be >
      UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])
    expect(UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])).to eql(
      UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]))
  end

  it "should produce the correct hexdigest for a UUID" do
    expect(UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]).hexdigest).to eql(
      '00000000000000000000000000000000')
    expect(UUIDTools::UUID.new(1, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]).hexdigest).to eql(
      '00000001000000000000000000000000')
    expect(UUIDTools::UUID.timestamp_create.hexdigest.size).to eql(32)
  end

  it "should produce a sane hash value for a UUID" do
    uuid = UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])
    expect(uuid.to_i).to eql(0)
    expect(uuid.hash).to be_kind_of(Fixnum)
  end

  it "should produce the correct URI for a UUID" do
    expect(UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]).to_uri).to eql(
      'urn:uuid:00000000-0000-0000-0000-000000000000')
  end

  it "should correctly test UUID equality" do
    expect(UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])).to eql(
      UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])
    )
  end

  it "should correctly parse integers" do
    expect(UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])).to eql(
      UUIDTools::UUID.parse_int(0))
    expect(UUIDTools::UUID.parse_int(0)).to be_nil_uuid
    uuid = UUIDTools::UUID.timestamp_create
    expect(UUIDTools::UUID.parse_int(uuid.to_i)).to eql(uuid)
  end

  it "should correctly parse hexdigests" do
    expect(UUIDTools::UUID.new(0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0])).to eql(
      UUIDTools::UUID.parse_hexdigest('00000000000000000000000000000000'))
    expect(UUIDTools::UUID.parse_hexdigest(
      '00000000000000000000000000000000'
    )).to be_nil_uuid
    uuid = UUIDTools::UUID.timestamp_create
    expect(UUIDTools::UUID.parse_hexdigest(uuid.hexdigest)).to eql(uuid)
  end
end
