class Market < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :street
    validates_presence_of :city
    validates_presence_of :county
    validates_presence_of :state
    validates_presence_of :zip
    validates_presence_of :lat
    validates_presence_of :lon

    has_many :market_vendors, dependent: :destroy
    has_many :vendors, through: :market_vendors

    def self.find_markets(name, city, state)
      @markets = []
      result = pass_muster?(name, city, state)
      if result
        Market.where("name ILIKE ? and city ILIKE ? and state ILIKE ?", "%#{name}%", "%#{city}%", "%#{state}%")
      else
       false
      end
    end

    def self.pass_muster?(name, city, state)
      return false if !city.nil? && state.nil?
      true
    end

    def nearby_atms
      atms = []
      atm_json = TomTomService.nearby_atms(lat, lon)
      atm_json[:results].each do |atm_data|
        atms << Atm.new(atm_data)
      end
      atms
    end
end