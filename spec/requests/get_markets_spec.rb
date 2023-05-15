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
      expect(@json.size).to eq(5)
      expect(@json).to all(have_key(:name))
      expect(@json).to all(have_key(:street))
      expect(@json).to all(have_key(:city))
      expect(@json).to all(have_key(:county))
      expect(@json).to all(have_key(:state))
      expect(@json).to all(have_key(:zip))
      expect(@json).to all(have_key(:lat))
      expect(@json).to all(have_key(:lon))
    end
  end
end