class PackagesController < ApplicationController
  before_filter      :authenticate_user!
  # skip_before_filter :verify_authenticity_token
  def index
    if current_user.reseller?
      @packages = Package.find(params[:id]).package_payloads.insert_order #order("site asc")
      render json: @packages
    else
      error = {:error => :access_denied}
      render json: error, :status => 403
    end
  end

  def destroy
    if current_user.reseller?
      package = PackagePayload.find(params[:id])
      package.delete
      render json: true
    else
      error = {:error => :access_denied}
      render json: error, :status => 403
    end
  end

  def reorder 
    package = Package.find(params[:id]) 
    if can? :edit, package
      params[:payload_ids].each_with_index do |id, index|
        PackagePayload.where(id: id).where(package_id: package.id).update_all( queue_insert_order: index)
      end 
      render json: true
    else 
      error = {:error => :access_denied}
      render json: error, :status => 403
    end 
  end 

  def create
    if current_user.reseller?
      PackagePayload.create do |pac|
        pac.package_id = params[:id]
        pac.site       = params[:category]
        pac.payload    = params[:payload_id]
      end
      render json: true
    else
      error = {:error => :access_denied}
      render json: error, :status => 403
    end
  end
end
