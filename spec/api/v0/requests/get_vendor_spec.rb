require 'rails_helper'

RSpec.describe "Get One Vendor", type: :request do
  describe "Happy Path" do
    before do
      test_data
    end

    it "returns one vendor" do
      get api_v0_vendor_path(@vendor_6)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(json.count).to eq(1)
      expect(json).to have_key(:data)
      expect(json[:data][:id]).to eq(@vendor_6.id.to_s)
      expect(json[:data]).to have_key(:type)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:name)
      expect(json[:data][:attributes]).to have_key(:description)
      expect(json[:data][:attributes]).to have_key(:contact_name)
      expect(json[:data][:attributes]).to have_key(:contact_phone)
      expect(json[:data][:attributes]).to have_key(:credit_accepted)
    end
  end

  describe "Sad Path" do
    it "returns proper error" do
      get "/api/v0/vendors/64738209387"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(response).to have_http_status(:not_found)
      expect(json).to have_key(:errors)
      expect(json[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=64738209387")
    end
  end
end