class Api::V0::MarketVendorsController < ApplicationController
  def create
    @market_vendor = MarketVendor.new(market_vendor_params)
    if @market_vendor.save
      render json: MarketVendorSerializer.new(@market_vendor, action: :create).serializable_hash[:data].merge(message: "Successfully added vendor to market"), status: :created
    else
      @error_market_vendor = ErrorMarketVendor.new(@market_vendor)
      render json: @error_market_vendor, status: @error_market_vendor.code
    end
  end

  def destroy
    @market_vendor = MarketVendor.find_by(market_id: params[:market_id], vendor_id: params[:vendor_id])
    if @market_vendor
      MarketVendor.find(@market_vendor.id).destroy
      render json: {}, status: 204
    else
      error_market_vendor = ErrorMarketVendor.new(MarketVendor.new(market_id: params[:market_id], vendor_id: params[:vendor_id]))
      render json: error_market_vendor, status: error_market_vendor.code
    end      
  end

  private
    def market_vendor_params
      params.permit(:market_id, :vendor_id)
    end

    def not_found(exception)
      render json: SearchFacade.handle_missing_mv_error(exception), status: :not_found
    end
end