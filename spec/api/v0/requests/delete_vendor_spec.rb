require "rails_helper"

RSpec.describe "delete vendor", type: :request do
  describe "Happy Path" do
    before do
      test_data
    end

    it "deletes vendor" do
      expect(Vendor.count).to eq(10)

      delete "/api/v0/vendors/#{@vendor_4.id}"

      expect(Vendor.count).to eq(9)
      expect(response).to have_http_status(204)
      expect(response.body).to eq("")
    end
  end

  describe "Sad Path" do
    before do
      test_data
    end

    it "returns 404 if bad id" do
      get "/api/v0/vendors/64738209387"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(response).to have_http_status(:not_found)
      expect(json).to have_key(:errors)
      expect(json[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=64738209387")
    end
  end
end