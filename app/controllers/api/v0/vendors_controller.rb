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
      render json: VendorSerializer.new(Vendor.find(@vendor.id)), status: :created
    else
      render json: { errors: @vendor.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    Vendor.find(params[:id]).destroy
    render json: {}, status: :no_content
  end

  def update
    @vendor = Vendor.find(params[:id])
    if @vendor.update(vendor_params)
      render json: VendorSerializer.new(@vendor)
    else
      render json: { errors: @vendor.errors.full_messages }, status: :bad_request
    end
  end

  def multiple_states
    results = Vendor.many_states
    render json: VendorSerializer.new(results).serializable_hash.merge(results: results.count)
  end

  def popular_states
    yams = Vendor.states_by_popularity(params[:limit])
    render json: yams
  end

  def popularity_by_state
    render json: VendorSerializer.new(Vendor.most_popular_vendor_by_state(params[:state]))
  end

  
  private 
    
    def not_found(exception)
      render json: SearchFacade.handle_missing_error(exception), status: :not_found
    end

    def vendor_params
      params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
    end
end