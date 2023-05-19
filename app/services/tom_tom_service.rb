require 'faraday'

class TomTomService
  def self.conn
    Faraday.new(
      url: "https://api.tomtom.com"
    )
  end

  def self.nearby_atms(lat, lon)
    response = conn.get("/search/2/nearbySearch/.json?key=#{ENV["tomtom_api_key"]}&lat=#{lat}&lon=#{lon}&key=#{ENV["tomtom_api_key"]}")
    JSON.parse(response.body, symbolize_names: true)
  end
end