require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  describe "validations and relations" do
    
    it { should validate_presence_of :market_id }
    it { should validate_presence_of :vendor_id }
    
    it { should belong_to :market }
    it { should belong_to :vendor }
    
    it "validates vendor-market uniqueness" do
      test_data
      market_vendor = MarketVendor.new(vendor_id: @vendor_1.id, market_id: @market_1.id)
      expect(market_vendor.save).to eq(false)
    end
  end
end