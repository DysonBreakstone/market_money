class MarketVendor < ApplicationRecord
  validate :pairing_already_exists, on: :create

  belongs_to :market
  belongs_to :vendor

  def pairing_already_exists
    existing_market_vendor = MarketVendor.find_by(market_id: market_id, vendor_id: vendor_id)
    if existing_market_vendor && existing_market_vendor != self
      errors.add(:base, "Market vendor association between market with market_id=#{market_id} and vendor_id=#{vendor_id} already exists")
    end
  end
end