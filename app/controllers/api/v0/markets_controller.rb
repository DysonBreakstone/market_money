class  Api::V0::MarketsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :market_not_found

  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    @market = Market.find(params[:id])
    render json: MarketSerializer.new(@market)
  end

  def market_not_found(exception)
    render json: {errors: [
                    {
                      detail: exception.message 
                    }
                     ]
                  }, status: :not_found
  end
end