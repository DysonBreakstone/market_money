require 'rails_helper'

RSpec.describe "Happy Path", type: :request do
  describe "create vendor" do
    before do
      test_data
    end

    it "creates vendor with given all attributes" do
      expect(Vendor.count).to eq(10)
      post "/api/v0/vendors", params: { 
                                        name: "Vendor 11"
                                        description: "Description Eleven"
                                        contact_name: "Contact Eleven"
                                        contact_phone: "(111) 111-1111"
                                        credit_accepted: true
                                      }
      expect(Vendor.count).to eq(11)
    end
  end
end