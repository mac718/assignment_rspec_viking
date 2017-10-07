require 'weapons/bow'

describe Bow do 

  let(:bow) { Bow.new }

  describe "#arrows" do 
    it "should be an Integer" do 
      expect(bow.arrows).to be_an(Integer)
    end
  end

  describe "#intialize" do 
    context "no arguments given" do 
      it "initializes arrows to 10" do 
        expect(bow.arrows).to eql(10)
      end
    end


    context "argument given" do 
      let(:bow) { Bow.new(15) }
      it "initializes arrows to number passed in" do 
        expect(bow.arrows).to eql(15)
      end
    end
  end

  describe "#use" do 
    it "reduces arrow count by 1" do 
      bow.use 
      expect(bow.arrows).to eql(9)
    end
    
    context "arrow count is 0" do
      let(:bow) { Bow.new(0) }
      it "throws an error" do
        expect{ bow.use }.to raise_error(RuntimeError)
      end
    end
  end
end
