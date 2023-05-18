require "rails_helper"

RSpec.desribe "Market Search", type: :request do
  describe "Happy Path" do
    before do 
      test_data
      @market_11 = Market.create!(name: "Market 11", street: "One Street", city: "One City", county: "One County", state: "One State", zip: "11111", lat: "38.9169984", lon: "-77.0320505")
      @market_12 = Market.create!(name: "Market 12", street: "Two Street", city: "Two City", county: "Two County", state: "Two State", zip: "22222", lat: "38.9169984", lon: "-77.0320505")
    end

    it "searches for markets based on combinations of state, city, and name" do
      params_array = [
                      {state: "State"},
                      {state: "State", city: "City"},
                      {state: "State", city: "City", name: "Market"},
                      {state: "State", name: "Market"},
                      {name: "Market"}
                     ]
      params_array.each do |param|
        get "/api/v0/markets/search", params: param

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(200)
        expect(json[:data]).to be_a(Array)
        expect(json[:data].count).to eq(5)
        require 'pry'; binding.pry
      end
    end

    it "narrows down search" do
      get "/api/v0/markets/search", params: {state: "One"}
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(2)

      get "/api/v0/markets/search", params: {state: "One", name: 11}
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(1)
    end

    it "still returns an array with one item if only one object is returned" do
      get "/api/v0/markets/search", params: {state: "Three"}
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key([:data])
      expect(json[:data]).to be_a(Array)
    end
  end

  describe "Sad Path" do
    describe "invalid params" do
      before do 
        test_data
      end

      it "all invalid params" do
        i_params = [
          {city: "City"},
          {city: "City", name: "Market"},
          {name: "Market", city: "City"},
          {zip: "11111"},
          {lat: "38.9169984"},
          {lon: "-77.0320505"},
          {fake_param: "Fake Data"}
          ]
        i_params.each do |param|
          get "/api/v0/markets/search", params: param
          json = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(422)
          expect(json[:errors]).to eq(["Search parameters must be some combination of City, State, and Name. City by itself, or City and Name without an associated State will not suffice."])
        end  
        
      it "valid params but no markets" do
        get "/api/v0/markets/search", params: {state: "Flurb"}
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(200)
        expect(json).to have_key(:data)
        expect(json[:data]).to eq([])
      end
    end
  end
end