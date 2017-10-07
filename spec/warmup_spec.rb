require 'warmup'

describe Warmup do 
  let(:warmup) { Warmup.new }
  describe "#gets_shout" do 
    it "sets the variable shout to user inputted string" do 
      allow(warmup).to receive(:gets).and_return("hello")

      expect(warmup.gets_shout).to eql("HELLO")
    end 
  end

  describe "triple_size" do 
    it "returns 3 times the size of a passed in array" do 
      my_array = double(:size => 3)
      expect(warmup.triple_size(my_array)).to eql(9)
    end
  end

  describe "#calls_some_methods" do
    it "checks weather string receives #upcase!" do
      string = "hello"
      expect(string).to receive(:upcase!).and_return("HELLO")
      warmup.calls_some_methods(string)
    end

    it "checks weather string receives #reverse!" do
      string = "hello"
      expect(string).to receive(:reverse!).and_return("OLLEH")
      warmup.calls_some_methods(string)
    end

    it "checks weather string receives #reverse!" do
      string = "hello"
      expect(string.object_id).not_to eql(warmup.calls_some_methods(string).object_id)
    end
  end
end
