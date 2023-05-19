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

  def self.many_states
    vendors = []
    Vendor.from(states_table, :this_table)
      .select("this_table.vendor, this_table.state_count")
      .where("this_table.state_count > 1")
      .order("this_table.state_count DESC")
      .each { |vendor| vendors << Vendor.find(vendor.vendor)}
    vendors
    end

  def self.states_table
    Vendor.joins(:markets).select("vendors.id as vendor, COUNT(markets.state) AS state_count").group("vendors.id")
  end


end