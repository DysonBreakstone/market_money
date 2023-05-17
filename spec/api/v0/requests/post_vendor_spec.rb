require 'rails_helper'

RSpec.describe "Happy Path", type: :request do
  describe "create vendor" do
    before do
      test_data
    end

    it "creates vendor with given all attributes" do
      expect(Vendor.count).to eq(10)
      post "/api/v0/vendors", params: { 
                                        name: "Vendor 11",
                                        description: "Description Eleven",
                                        contact_name: "Contact Eleven",
                                        contact_phone: "(111) 111-1111",
                                        credit_accepted: true
                                      }
      expect(Vendor.count).to eq(11)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to have_key(:data)
      expect(json[:data][:attributes][:name]).to eq("Vendor 11")
    end
  end

  describe "Sad Path" do
    it "gives back bad request" do
      post "/api/v0/vendors", params: { 
        name: "Vendor 11",
        contact_name: "Contact Eleven",
        contact_phone: "(111) 111-1111",
      }
    json = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(json[:errors]).to eq(["Description can't be blank", "Credit accepted is not included in the list"])
    end
  end
end