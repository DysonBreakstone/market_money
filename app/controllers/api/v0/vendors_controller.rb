class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    render json: VendorSerializer.new(Vendor.find_market_vendors(params[:market_id]))
  end

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create
    @vendor = Vendor.new(name: params[:name],
                         description: params[:description],
                         contact_name: params[:contact_name],
                         contact_phone: params[:contact_phone],
                         credit_accepted: params[:credit_accepted])
    if @vendor.save
      render json: VendorSerializer.new(Vendor.find(@vendor.id))
    else
      render json: { errors: @vendor.errors.full_messages }, status: :bad_request
    end
  end

  def not_found(exception)
    render json: SearchFacade.handle_missing_error(exception), status: :not_found
  end
end