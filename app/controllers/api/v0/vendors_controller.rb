class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    render json: VendorSerializer.new(Vendor.find_market_vendors(params[:market_id]))
  end

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      render json: VendorSerializer.new(Vendor.find(@vendor.id))
    else
      render json: { errors: @vendor.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @vendor = Vendor.find(params[:id])
    # if @vendor.update()
  end

  def not_found(exception)
    render json: SearchFacade.handle_missing_error(exception), status: :not_found
  end

  private 
    def vendor_params
      params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
    end
end