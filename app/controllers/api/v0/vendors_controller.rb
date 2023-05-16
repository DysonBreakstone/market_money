class Api::V0::VendorsController < ApplicationController
  def index
    render json: VendorSerializer.new(Vendor.find_market_vendors(params[:market_id]))
  end
end