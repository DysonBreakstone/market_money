class Vendor < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :contact_name
  validates_presence_of :contact_phone
  validates_inclusion_of :credit_accepted, in: [true, false]

  has_many :market_vendors, dependent: :destroy
  has_many :markets, through: :market_vendors

  def self.find_market_vendors(market)
    Market.find(market).vendors
  end
end