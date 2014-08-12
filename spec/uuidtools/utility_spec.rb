require File.expand_path("../../spec_helper.rb", __FILE__)

describe SecureRandom do
  it "should correctly obtain random bits" do
    bits = []
    1000.times do
      bits << SecureRandom.random_bytes(16)
    end
    # Check to make sure that none of the 10,000 strings were duplicates
    expect((bits.map {|x| x.to_s}).uniq.size).to eql(bits.size)
  end

  it "should return the correct number of random bits" do
    expect(SecureRandom.random_bytes(16).size).to eql(16)
    expect(SecureRandom.random_bytes(6).size).to eql(6)
  end

  it "should return a sane random number" do
    expect(SecureRandom.random_number(5000)).to be < 5000
  end
end
