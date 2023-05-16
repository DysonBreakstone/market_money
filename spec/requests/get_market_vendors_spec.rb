require 'rails_helper'

RSpec.describe "get all vendors for a market" do
  describe "Happy Path" do
    before do
      test_data
    end
    it "returns expected Vendors" do
      get api_v0_market_vendors_path(@market_2.id)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(json).to have_key(:data)
      expect(json[:data].size).to eq(3)
      expect(json[:data][:attributes]).to all(have_key(:name))
      expect(json[:data][:attributes]).to all(have_key(:description))
      expect(json[:data][:attributes]).to all(have_key(:contact_name))
      expect(json[:data][:attributes]).to all(have_key(:contact_phone))
      expect(json[:data][:attributes]).to all(have_key(:credit_accepted))
      expect(json[:data][0][:id])
      
      vendor_array = json[:data].map{ |vendor| vendor.id }
      expected_array = [@vendor_3.id, @vendor_4.id, @vendor_8.id]

      expect(vendor_array).to eq(expected_array)
    end
  end
end