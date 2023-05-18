require 'rails_helper'

RSpec.describe "get nearby atms", type: :request do
  describe "Happy Path" do
    before do
      test_data
    end

    it "gets atms" do
      data_keys = [:id, :type, :attributes]
      attr_keys = [:name, :address, :lat, :lon, :distance]
      get "/api/v0/markets/#{@market_1.id}/nearest_atm"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json).to have_key(:data)
      expect(json[:data].count).to eq(10)
      expect(json[:data].first.keys.sort).to eq(data_keys.sort)
      expect(json[:data].first[:attributes].keys.sort).to eq(attr_keys.sort)
      base = json[:data].first[:attributes]
      attr_keys[0..1].each do |attr|
        expect(base[attr]).to be_a(String)
      end
      attr_keys[2..4].each do |attr|
        expect(base[attr]).to be_a(Float)
      end
    end
  end

  describe "Sad Path" do
    before do
      test_data
    end

    it "returns empty" do
      @market_80 = Market.create!(name: "Market 1", street: "One Street", city: "One City", county: "One County", state: "One State", zip: "11111", lat: "90", lon: "135")
      get "/api/v0/markets/#{@market_80.id}/nearest_atm"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json).to have_key(:data)
    end

    it "non-existent market" do
      get "/api/v0/markets/5151848451518484/nearest_atm"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(json).to have_key(:errors)
      expect(json[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=5151848451518484")
    end
  end
end