require "rails_helper"

RSpec.describe "delete vendor", type: :request do
  describe "Happy Path" do
    before do
      test_data
    end

    it "deletes vendor" do
      expect(Vendor.count).to eq(10)

      delete "/api/v0/vendors/#{@vendor_4.id}"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(Vendor.count).to eq(9)
      expect(response).to have_http_status(204)
      require 'pry'; binding.pry
    end
  end
end