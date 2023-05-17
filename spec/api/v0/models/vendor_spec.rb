require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe "validations and relations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :contact_name}
    it {should validate_presence_of :contact_phone}
    it {should validate_inclusion_of(:credit_accepted).in_array([true, false]) }

    it {should have_many :market_vendors}
    it {should have_many(:markets).through(:market_vendors)}
  end

  describe "class methods" do
    before do
      test_data
    end
    it "::find_market_vendors" do
      expect(Vendor.find_market_vendors(@market_3.id)).to eq([@vendor_5, @vendor_6, @vendor_7])
    end
  end
end