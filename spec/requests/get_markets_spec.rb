require 'rails_helper'

RSpec.describe "market index request", type: :request do
  describe "json" do
    before do
      test_data
      get '/api/v0/markets'
      @json = JSON.parse(response.body, symbolize_names: true)
    end

    it "status code 200" do
      expect(response).to have_http_status(:success)
    end

    it "shows markets" do
      expect(@json[:data].size).to eq(5)
      expect(@json[:data].first[:attributes]).to have_key(:name)
      expect(@json[:data].first[:attributes]).to have_key(:street)
      expect(@json[:data].first[:attributes]).to have_key(:city)
      expect(@json[:data].first[:attributes]).to have_key(:county)
      expect(@json[:data].first[:attributes]).to have_key(:state)
      expect(@json[:data].first[:attributes]).to have_key(:zip)
      expect(@json[:data].first[:attributes]).to have_key(:lat)
      expect(@json[:data].first[:attributes]).to have_key(:lon)
      expect(@json[:data].first[:attributes]).to have_key(:vendor_count)
    end
  end
end