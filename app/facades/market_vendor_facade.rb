class MarketVendorFacade
  def self.error_status(market_vendor)
    if market_vendor.errors.full_messages.first.include?("Market vendor association")
      return 422
    else
      return 404
    end
  end
end