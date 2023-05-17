class Api::V0::MarketVendorsController < ApplicationController
  def create
    @market_vendor = MarketVendor.new(market_vendor_params)
    if @market_vendor.save
      render json: MarketVendorSerializer.new(@market_vendor)
    else
      @error_market_vendor = ErrorMarketVendor.new(@market_vendor)
      render json: @error_market_vendor, status: @error_market_vendor.code
    end
  end

  private
    def market_vendor_params
      params.permit(:market_id, :vendor_id)
    end
end