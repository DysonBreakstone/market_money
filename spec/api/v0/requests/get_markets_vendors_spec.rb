require 'rails_helper'

RSpec.describe "get all vendors for a market" do
  describe "Happy Path" do
    before do
      test_data
    end

    it "returns expected Vendors" do
      get "/api/v0/markets/#{@market_2.id}/vendors"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(json).to have_key(:data)
      expect(json[:data].size).to eq(3)
      expect(json[:data][0][:attributes]).to have_key(:name)
      expect(json[:data][0][:attributes]).to have_key(:description)
      expect(json[:data][0][:attributes]).to have_key(:contact_name)
      expect(json[:data][0][:attributes]).to have_key(:contact_phone)
      expect(json[:data][0][:attributes]).to have_key(:credit_accepted)
      
      vendor_array = json[:data].map{ |vendor| vendor[:id].to_i }
      expected_array = [@vendor_3.id, @vendor_4.id, @vendor_8.id]

      expect(vendor_array).to eq(expected_array)
    end
  end

  describe "Sad Path" do
    before do
      test_data
    end
    
    it "returns expected Vendors" do
      get "/api/v0/markets/982734987234/vendors"
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(404)
      expect(response).to have_http_status(:not_found)
      expect(json).to have_key(:errors)
      expect(json[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=982734987234")
    end
  end
end