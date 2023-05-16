class  Api::V0::MarketsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :market_not_found

  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    @market = Market.find(params[:id])
    render json: MarketSerializer.new(@market)
  end

  def vendors
    render json: VendorSerializer.new(Vendor.find_market_vendors(params[:id]))
  end


  def market_not_found(exception)
    render json: MarketFacade.handle_missing_error(exception), status: :not_found
  end
end