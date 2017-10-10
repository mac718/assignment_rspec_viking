require 'pry'
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

  describe "#receive_attack" do 
    it "reduces the viking's health by the specified amount" do 
      viking.receive_attack(10)
      expect(viking.health).to eql(90)
    end

    it "calls the #take_damage method" do 
      expect(viking).to receive(:take_damage)
      viking.receive_attack(10)
    end
  end

  describe "#attack" do 
    let(:attacker) { Viking.new("Sven", 100, 10, axe) }
    it "causes the target viking's health to drop" do 
      attacker.attack(viking)
      expect(viking.health).to be < 100
    end

    it "calls the target viking's #take_damage method" do 
      expect(viking).to receive(:take_damage)
      attacker.attack(viking)
    end

    context "attacking viking has no weapon" do
      fists = Fists.new
      before do 
        attacker.drop_weapon
      end 

    # unsure about next two tests
      it "calls #damage_with_fists" do 
        expect(attacker).to receive(:damage_with_fists).and_return(2.5)
        attacker.attack(viking)
      end

      it "deals Fists-multiplier-times-strength damage" do
        fists_multiplier = fists.use 
        damage_inflicted = fists_multiplier * attacker.strength 
        attacker.attack(viking)
        expect(viking.health).to eql(100 - damage_inflicted)
      end
    end

    context "attacking viking has a weapon" do 
      it "calls #damage_with_weapon method" do 
        expect(attacker).to receive(:damage_with_weapon).and_return(10)
        attacker.attack(viking)
      end

      it "deals weapon-multiplier-times-strength damage" do
        axe_multiplier = axe.use 
        damage_inflicted = axe_multiplier * attacker.strength 
        attacker.attack(viking)
        expect(viking.health).to eql(100 - damage_inflicted)
      end
    end

    context "viking is attacking with a bow with no arrows" do
      let(:attacker) { Viking.new("Sven", 100, 10, Bow.new(0)) } 
      it "forces the viking to attack with fists" do 
        expect(attacker).to receive(:damage_with_fists).and_return(2.5)
        attacker.attack(viking)
      end
    end

    let(:target) { Viking.new("Olaf", 5)}
    it "raises and error if attacked viking dies" do 
      expect{attacker.attack(target)}.to raise_error(RuntimeError)
    end
  end
end

