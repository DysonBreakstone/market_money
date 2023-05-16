class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    render json: VendorSerializer.new(Vendor.find_market_vendors(params[:market_id]))
  end

  def not_found(exception)
    render json: SearchFacade.handle_missing_error(exception), status: :not_found
  end
end