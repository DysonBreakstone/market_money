require 'rails_helper'

RSpec.describe Market, type: :model do
  describe "validations and relations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :street}
    it {should validate_presence_of :city}
    it {should validate_presence_of :county}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :lat}
    it {should validate_presence_of :lon}

    it {should have_many :market_vendors}
    it {should have_many(:vendors).through(:market_vendors)}
  end

  describe "helper_methods" do
    before do
      @params_array = [
                      {state: "State"},
                      {state: "State", city: "City"},
                      {state: "State", city: "City", name: "Market"},
                      {state: "State", name: "Market"},
                      {name: "Market"}
                     ]
      @i_params = [
          {city: "City"},
          {city: "City", name: "Market"},
          {name: "Market", city: "City"},
          ]
      @market = Market.create!(name: "Market 12", street: "Two Street", city: "Two City", county: "Two County", state: "Two State", zip: "22222", lat: "38.9169984", lon: "-77.0320505")
    end

    it "pass_muster happy" do
      @params_array.each do |param|
        expect(Market.pass_muster?(param[:name], param[:city], param[:state])).to eq(true)
      end
    end

    it "#pass_muster sad" do
      @i_params.each do |param|
        expect(Market.pass_muster?(param[:name], param[:city], param[:state])).to eq(false)
      end
    end
  end

  describe "class_methods" do
    before do 
      test_data
      @market_11 = Market.create!(name: "Market 11", street: "One Street", city: "One City", county: "One County", state: "One State", zip: "11111", lat: "38.9169984", lon: "-77.0320505")
      @market_12 = Market.create!(name: "Market 12", street: "Two Street", city: "Two City", county: "Two County", state: "Two State", zip: "22222", lat: "38.9169984", lon: "-77.0320505")
    end

    it "find_markets happy" do
      expect(Market.find_markets("1", "One", "One").count).to eq(2)
      expect(Market.find_markets("11", nil, "One").count).to eq(1)
    end

    it "find_markets_sad" do
      expect(Market.find_markets(nil, "City", nil)).to eq(false)
      expect(Market.find_markets("1", "City", nil)).to eq(false)
    end
  end
end