require 'rails_helper'

RSpec.describe "market show request", type: :request do
  describe "response" do
    before do
      test_data
    end
    
    it "Happy Path" do
      get api_v0_market_path(@market_1.id)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(json).to have_key(:data)
      expect(json.size).to eq(1)
      expect(json[:data][:id]).to eq(@market_1.id.to_s)
      expect(json[:data][:attributes]).to have_key(:name)
      expect(json[:data][:attributes]).to have_key(:street)
      expect(json[:data][:attributes]).to have_key(:city)
      expect(json[:data][:attributes]).to have_key(:county)
      expect(json[:data][:attributes]).to have_key(:state)
      expect(json[:data][:attributes]).to have_key(:zip)
      expect(json[:data][:attributes]).to have_key(:lat)
      expect(json[:data][:attributes]).to have_key(:lon)
      expect(json[:data][:attributes]).to have_key(:vendor_count)
    end

    it "sad path" do
      get api_v0_market_path(7474747474)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
      expect(json).to have_key(:errors)
      expect(json[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=7474747474")
    end
  end
end