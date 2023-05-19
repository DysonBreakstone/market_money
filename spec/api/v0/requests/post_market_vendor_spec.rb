require 'rails_helper'

RSpec.describe "post market_vendor", type: :request do
  describe "happy path" do
    before do
      test_data
    end

    it "creates new market_vendor" do
      expect(MarketVendor.count).to eq(15)
      expect(@market_5.vendors.sort).to eq([@vendor_2, @vendor_9, @vendor_10].sort)
      expect(@vendor_3.markets).to eq([@market_2])

      post "/api/v0/market_vendors", params: {
        market_id: @market_5.id,
        vendor_id: @vendor_3.id
      }
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(201)
      require 'pry'; binding.pry
      @market_5.reload
      @vendor_3.reload
      
      expect(MarketVendor.count).to eq(16)
      expect(@market_5.vendors.sort).to eq([@vendor_2, @vendor_9, @vendor_10, @vendor_3].sort)
      expect(@vendor_3.markets.sort).to eq([@market_2, @market_5].sort)
    end
  end

  describe "Sad Paths" do
    before do
      test_data
    end

    it "already exists" do
      post "/api/v0/market_vendors", params: {
          market_id: @market_5.id,
          vendor_id: @vendor_2.id
        }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(422)
      expect(json).to have_key(:errors)
      expect(json[:errors]).to eq(["Validation failed: Market vendor association between market with market_id=#{@market_5.id} and vendor_id=#{@vendor_2.id} already exists"])
    end

    it "vendor id is missing" do
      post "/api/v0/market_vendors", params: {
        market_id: @market_5.id,
        vendor_id: ""
      }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(json[:errors]).to eq(["Validation failed: Vendor must exist"])
    end

    it "market id is missing" do
      post "/api/v0/market_vendors", params: {
        market_id: "",
        vendor_id: @vendor_2.id
      }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(json[:errors]).to eq(["Validation failed: Market must exist"])
    end
  end
end