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

  def self.state_count_table
    Vendor.joins(:markets).select("markets.state AS state, COUNT(vendors.id) AS vendor_count").group("markets.state")
  end

  def self.states_by_popularity(limit)
    subquery = state_count_table
    states = {data: []}
    Vendor.from(subquery, :state_count)
      .select("state_count.state, state_count.vendor_count")
      .order("state_count.vendor_count DESC")
      .limit(limit)
      .each do |vendor| 
        states[:data] << { state: vendor.state, number_of_vendors: vendor.vendor_count } 
      end
    states
  end

  def self.most_popular_vendor_by_state(state)
    Vendor.joins(:markets)
      .where("markets.state='#{state}'")
      .joins(:market_vendors)
      .select("vendors.* AS vendor, COUNT(market_vendors.*) AS market_count")
      .group("vendors.id")
      .order("market_count DESC")
  end

end