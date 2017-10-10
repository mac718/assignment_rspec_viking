require 'viking'

describe Viking do 

  let(:viking) { Viking.new }
  let(:axe) { Axe.new }
  let(:bow) { Bow.new }

  describe "#initialize" do 
    context "name passed in" do 
      let (:viking) { Viking.new("Sven")}
      it "sets name attribute to passed in name" do 
        expect(viking.name).to eql("Sven")
      end
    end

    context "health value passed in" do 
      let (:viking) { Viking.new("Sven", 98)}
      it "sets health attribute to passed in value" do 
        expect(viking.health).to eql(98)
      end

      it "does not allow the health value to be changed" do 
        expect { viking.health=(90) }.to raise_error(NoMethodError)
      end
    end

    context "no arguments passed in" do 
      it "initializes @weapon to nil" do 
        expect(viking.weapon).to eql(nil)
      end
    end
  end

  describe "#pick_up_weapon" do 
    context "viking picks up weapon object" do 
      it "saves the picked up weapon to @weapon" do 
        viking.pick_up_weapon(axe)
        expect(viking.weapon).to eql(axe)
      end
    end

    context "viking picks up a non-weapon" do 
      it "saves the picked up weapon to @weapon" do 
        expect{viking.pick_up_weapon('broom')}.to raise_error(RuntimeError)
      end
    end

    context "viking has a weapon and picks up a new one" do 
      it "replaces the viking's old weapon with the new one" do 
        viking.pick_up_weapon(axe)
        viking.pick_up_weapon(bow)
        expect(viking.weapon).to eql(bow)
      end
    end
  end

  describe "#drop_weapon" do 
    it "leaves the viking without a weapon" do 
      viking.pick_up_weapon(axe)
      viking.drop_weapon
      expect(viking.weapon).to eql(nil)
    end
  end
end

