require 'rails_helper'

RSpec.describe "vendor statistics" do
  describe "multiple states" do
    before do 
      @market_1 = Market.create!(name: "Market 1", street: "One Street", city: "One City", county: "One County", state: "One State", zip: "11111", lat: "38.9169984", lon: "-77.0320505")
      @market_2 = Market.create!(name: "Market 2", street: "Two Street", city: "Two City", county: "Two County", state: "One State", zip: "22222", lat: "38.9169984", lon: "-77.0320505")
      @market_3 = Market.create!(name: "Market 3", street: "Three Street", city: "Three City", county: "Three County", state: "Three State", zip: "33333", lat: "38.9169984", lon: "-77.0320505")
      @market_4 = Market.create!(name: "Market 4", street: "Four Street", city: "Four City", county: "Four County", state: "Four State", zip: "44444", lat: "38.9169984", lon: "-77.0320505")
      @market_5 = Market.create!(name: "Market 5", street: "Five Street", city: "Five City", county: "Five County", state: "Five State", zip: "55555", lat: "38.9169984", lon: "-77.0320505")

      @vendor_1 = Vendor.create!(name: "Vendor 1", description: "One Vendor", contact_name: "Contact One", contact_phone: "(111) 111-1111", credit_accepted: true)
      @vendor_2 = Vendor.create!(name: "Vendor 2", description: "Two Vendor", contact_name: "Contact Two", contact_phone: "(222) 222-2222", credit_accepted: false)
      @vendor_3 = Vendor.create!(name: "Vendor 3", description: "Three Vendor", contact_name: "Contact Three", contact_phone: "(333) 333-3333", credit_accepted: true)
      @vendor_4 = Vendor.create!(name: "Vendor 4", description: "Four Vendor", contact_name: "Contact Four", contact_phone: "(444) 444-4444", credit_accepted: false)
      @vendor_5 = Vendor.create!(name: "Vendor 5", description: "Five Vendor", contact_name: "Contact Five", contact_phone: "(555) 555-5555", credit_accepted: true)
      @vendor_6 = Vendor.create!(name: "Vendor 6", description: "Six Vendor", contact_name: "Contact Six", contact_phone: "(666) 666-6666", credit_accepted: false)
      @vendor_7 = Vendor.create!(name: "Vendor 7", description: "Seven Vendor", contact_name: "Contact Seven", contact_phone: "(777) 777-7777", credit_accepted: true)

      @market_vendor_1 = MarketVendor.create!(vendor_id: @vendor_1.id, market_id: @market_1.id)
      @market_vendor_2 = MarketVendor.create!(vendor_id: @vendor_2.id, market_id: @market_1.id)
      @market_vendor_3 = MarketVendor.create!(vendor_id: @vendor_2.id, market_id: @market_2.id)
      @market_vendor_4 = MarketVendor.create!(vendor_id: @vendor_3.id, market_id: @market_1.id)
      @market_vendor_5 = MarketVendor.create!(vendor_id: @vendor_3.id, market_id: @market_2.id)
      @market_vendor_6 = MarketVendor.create!(vendor_id: @vendor_3.id, market_id: @market_3.id)
      @market_vendor_7 = MarketVendor.create!(vendor_id: @vendor_4.id, market_id: @market_1.id)
      @market_vendor_8 = MarketVendor.create!(vendor_id: @vendor_4.id, market_id: @market_2.id)
      @market_vendor_9 = MarketVendor.create!(vendor_id: @vendor_4.id, market_id: @market_3.id)
      @market_vendor_10 = MarketVendor.create!(vendor_id: @vendor_4.id, market_id: @market_4.id)
      @market_vendor_11 = MarketVendor.create!(vendor_id: @vendor_5.id, market_id: @market_1.id)
      @market_vendor_12 = MarketVendor.create!(vendor_id: @vendor_5.id, market_id: @market_2.id)
      @market_vendor_13 = MarketVendor.create!(vendor_id: @vendor_5.id, market_id: @market_3.id)
      @market_vendor_14 = MarketVendor.create!(vendor_id: @vendor_5.id, market_id: @market_4.id)
      @market_vendor_15 = MarketVendor.create!(vendor_id: @vendor_5.id, market_id: @market_5.id)
      @market_vendor_16 = MarketVendor.create!(vendor_id: @vendor_6.id, market_id: @market_1.id)
      @market_vendor_17 = MarketVendor.create!(vendor_id: @vendor_7.id, market_id: @market_2.id)
    end

    it "only returns vendors with more than one state sold in" do
      get "/api/v0/vendors/multiple_states"
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)

      expect(json).to have_key(:results)
      expect(json[:results]).to eq(4)
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Array)
      expect(json[:data]).to all(be_a(Hash))
    end

    it "returns vendors in order" do
      get "/api/v0/vendors/multiple_states"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][0][:id].to_i).to eq(@vendor_5.id)
      expect(json[:data][1][:id].to_i).to eq(@vendor_4.id)
      expect(json[:data][2][:id].to_i).to eq(@vendor_3.id)
      expect(json[:data][3][:id].to_i).to eq(@vendor_2.id)
    end
  end

  describe "most popular states" do
    before do
      @market_1 = Market.create!(name: "Market 1", street: "One Street", city: "One City", county: "One County", state: "Two State", zip: "11111", lat: "38.9169984", lon: "-77.0320505")
      @market_2 = Market.create!(name: "Market 2", street: "Two Street", city: "Two City", county: "Two County", state: "One State", zip: "22222", lat: "38.9169984", lon: "-77.0320505")
      @market_3 = Market.create!(name: "Market 3", street: "Three Street", city: "Three City", county: "Three County", state: "Three State", zip: "33333", lat: "38.9169984", lon: "-77.0320505")
      @market_4 = Market.create!(name: "Market 4", street: "Four Street", city: "Four City", county: "Four County", state: "Four State", zip: "44444", lat: "38.9169984", lon: "-77.0320505")
      @market_5 = Market.create!(name: "Market 5", street: "Five Street", city: "Five City", county: "Five County", state: "Five State", zip: "55555", lat: "38.9169984", lon: "-77.0320505")
      @market_5 = Market.create!(name: "Market 6", street: "Six Street", city: "Six City", county: "Six County", state: "Six State", zip: "66666", lat: "38.9169984", lon: "-77.0320505")

      @vendor_1 = Vendor.create!(name: "Vendor 1", description: "One Vendor", contact_name: "Contact One", contact_phone: "(111) 111-1111", credit_accepted: true)
      @vendor_2 = Vendor.create!(name: "Vendor 2", description: "Two Vendor", contact_name: "Contact Two", contact_phone: "(222) 222-2222", credit_accepted: false)
      @vendor_3 = Vendor.create!(name: "Vendor 3", description: "Three Vendor", contact_name: "Contact Three", contact_phone: "(333) 333-3333", credit_accepted: true)
      @vendor_4 = Vendor.create!(name: "Vendor 4", description: "Four Vendor", contact_name: "Contact Four", contact_phone: "(444) 444-4444", credit_accepted: false)
      @vendor_5 = Vendor.create!(name: "Vendor 5", description: "Five Vendor", contact_name: "Contact Five", contact_phone: "(555) 555-5555", credit_accepted: true)
      @vendor_6 = Vendor.create!(name: "Vendor 6", description: "Six Vendor", contact_name: "Contact Six", contact_phone: "(666) 666-6666", credit_accepted: false)
      @vendor_7 = Vendor.create!(name: "Vendor 7", description: "Seven Vendor", contact_name: "Contact Seven", contact_phone: "(777) 777-7777", credit_accepted: true)

      @market_vendor_1 = MarketVendor.create!(vendor_id: @vendor_1.id, market_id: @market_3.id)
      @market_vendor_2 = MarketVendor.create!(vendor_id: @vendor_2.id, market_id: @market_3.id)
      @market_vendor_3 = MarketVendor.create!(vendor_id: @vendor_3.id, market_id: @market_3.id)
      @market_vendor_4 = MarketVendor.create!(vendor_id: @vendor_4.id, market_id: @market_3.id)
      @market_vendor_5 = MarketVendor.create!(vendor_id: @vendor_5.id, market_id: @market_3.id)
      @market_vendor_6 = MarketVendor.create!(vendor_id: @vendor_1.id, market_id: @market_2.id)
      @market_vendor_7 = MarketVendor.create!(vendor_id: @vendor_2.id, market_id: @market_2.id)
      @market_vendor_8 = MarketVendor.create!(vendor_id: @vendor_3.id, market_id: @market_2.id)
      @market_vendor_9 = MarketVendor.create!(vendor_id: @vendor_4.id, market_id: @market_2.id)
      @market_vendor_10 = MarketVendor.create!(vendor_id: @vendor_1.id, market_id: @market_5.id)
      @market_vendor_11 = MarketVendor.create!(vendor_id: @vendor_2.id, market_id: @market_5.id)
      @market_vendor_12 = MarketVendor.create!(vendor_id: @vendor_3.id, market_id: @market_5.id)
      @market_vendor_13 = MarketVendor.create!(vendor_id: @vendor_1.id, market_id: @market_1.id)
      @market_vendor_14 = MarketVendor.create!(vendor_id: @vendor_2.id, market_id: @market_1.id)
      @market_vendor_15 = MarketVendor.create!(vendor_id: @vendor_1.id, market_id: @market_4.id)
    end

    it "finds most popular state" do
      get "/api/v0/vendors/popular_states"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json).to have_key(:data)
      expect(json[:data]).to all(have_key(:state))
      expect(json[:data]).to all(have_key(:number_of_vendors))
      expect(json[:data].count).to eq(5)
      expect(json[:data].first[:state]).to eq("One State")
      expect(json[:data].first[:state]).to eq("Two State")
      expect(json[:data].first[:state]).to eq("Five State")
      expect(json[:data].first[:state]).to eq("One State")
      expect(json[:data].first[:state]).to eq("Four State")
      expect(json[:data].first[:number_of_vendors]).to eq(5)
      expect(json[:data].first[:number_of_vendors]).to eq(4)
      expect(json[:data].first[:number_of_vendors]).to eq(3)
      expect(json[:data].first[:number_of_vendors]).to eq(2)
      expect(json[:data].first[:number_of_vendors]).to eq(1)
    end

    it "has limit parameter" do
      get "/api/v0/vendors/popular_states", params: {limit: 4}
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json).to have_key(:data)
      expect(json[:data]).to all(have_key(:state))
      expect(json[:data]).to all(have_key(:number_of_vendors))
      expect(json[:data].count).to eq(4)

      get "/api/v0/vendors/popular_states", params: {limit: 3}
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data].count).to eq(3)

      get "/api/v0/vendors/popular_states", params: {limit: 2}
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data].count).to eq(2)

      get "/api/v0/vendors/popular_states", params: {limit: 1}
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data].count).to eq(1)
    end
  end
end