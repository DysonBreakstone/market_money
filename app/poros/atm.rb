class Atm 
  attr_reader :name,
              :address,
              :lat,
              :lon,
              :distance,
              :id

  def initialize(info)
    @name = info[:poi][:name]
    @distance = info[:dist]
    @address = info[:address][:freeformAddress]
    @lat = info[:position][:lat]
    @lon = info[:position][:lon]
    @id = nil
  end
end