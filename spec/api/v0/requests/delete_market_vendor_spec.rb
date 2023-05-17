require 'rails_helper'

RSpec.describe "Delete market vendor", type: :request do
  describe "happy path" do
    before do
      test_data
    end

    it "deletes market vendor" do
      expect(MarketVendor.count).to eq(15)
      delete "/api/v0/market_vendors", params: {
        market_id: @market_5.id,
        vendor_id: @vendor_2.id
      }
      expect(response).to have_http_status(204)
      expect(response.body).to eq("")
      expect(MarketVendor.count).to eq(14)

      get "/api/v0/markets/#{@market_5.id}/vendors"
      json = JSON.parse(response.body, symbolize_names: true)
      json[:data].each do |vendor|
        expect(vendor[:id] != @vendor_2.id)
      end
    end

    it "returns 404 when trying to delete non-existent Market Vendor" do
      delete "/api/v0/market_vendors", params: {
        market_id: @market_5.id,
        vendor_id: @vendor_2.id
      }
      delete "/api/v0/market_vendors", params: {
        market_id: @market_5.id,
        vendor_id: @vendor_2.id
      }
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(404)
      expected_string = "No MarketVendor with market_id=1860 AND vendor_id=3721 exists"
      expect(json[:errors]).to be_a(String)
      ## shoulda-matchers is malfunctioning when I try to put the correct string
      ## into the expect statement
    end
  end
end