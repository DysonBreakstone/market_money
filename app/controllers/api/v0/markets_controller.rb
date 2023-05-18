class  Api::V0::MarketsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

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


  def not_found(exception)
    render json: SearchFacade.handle_missing_error(exception), status: :not_found
  end

  def search
    result = Market.find_markets(search_params[:name], search_params[:city], search_params[:state])
    if result
      # if (params.keys - search_params.keys != ["controller", "action"])
      #   render json: SearchFacade.handle_bad_market_search, status: 422
      if search_params.empty?
        render json: SearchFacade.handle_empty_results, status: 200
      else
        render json: MarketSerializer.new(result), status: 200
      end
    else
      render json: SearchFacade.handle_bad_market_search, status: 422
    end
  end

  private
   def search_params
    params.permit(:city, :state, :name, :market)
   end
end