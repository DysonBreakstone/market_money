class MarketVendor < ApplicationRecord
  validates :market_id, uniqueness: { scope: :vendor_id }
  validates_presence_of :market_id
  validates_presence_of :vendor_id

  belongs_to :market
  belongs_to :vendor
end