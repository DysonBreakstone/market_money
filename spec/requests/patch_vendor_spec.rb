require 'rails_helper'

RSpec.describe "update vendor", type: :request do
  describe "Happy Path" do
    before do
      test_data
    end

    it "creates vendor with given all attributes" do
      expect(@vendor_1.name).to eq("Vendor 1")
      expect(@vendor_1.description).to eq("One Vendor")
      expect(@vendor_1.contact_name).to eq("Contact One")
      expect(@vendor_1.contact_phone).to eq("(111) 111-1111")
      expect(@vendor_1.credit_accepted).to eq(true)
      patch "/api/v0/vendors/#{@vendor_1.id}", params: { 
                                              name: "Vendor 11",
                                              description: "Description Eleven",
                                              contact_name: "Contact Eleven",
                                              contact_phone: "(111) 111-1111",
                                              credit_accepted: false
                                              }
      expect(@vendor_1.name).to eq("Vendor 11")
      expect(@vendor_1.description).to eq("Description Eleven")
      expect(@vendor_1.contact_name).to eq("Contact Eleven")
      expect(@vendor_1.contact_phone).to eq("(111) 111-1111")
      expect(@vendor_1.credit_accepted).to eq(false)
      
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to have_key(:data)
      expect(json[:data][:attributes][:name]).to eq("Vendor 11")
    end
  end

  describe "Sad Path" do
  end
end