require File.join(File.dirname(__FILE__), "../spec_helper.rb")

describe UUID, "when using utility methods" do
  it "should correctly obtain random bits" do
    bits = []
    1000.times do
      bits << UUID.random_bits(128)
    end
    # Check to make sure that none of the 10,000 strings were duplicates
    (bits.map {|x| x.to_s}).uniq.size.should == bits.size
  end

  it "should return the correct number of random bits" do
    UUID.random_bits(128).size.should == 16
    UUID.random_bits(48).size.should == 6
  end

  it "should throw an exception for a bit size indivisible by 16" do
    (lambda do
      UUID.random_bits(12)
    end).should raise_error(ArgumentError)
  end
end
