require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  describe "validations and relations" do
    it {should validate_presence_of :market_id}
    it {should validate_presence_of :vendor_id}

    it {should belong_to :market}
    it {should belong_to :vendor}
  end
end