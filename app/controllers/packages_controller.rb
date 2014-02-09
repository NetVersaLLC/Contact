class PackagesController < ApplicationController
  def index
    package = Package.find(params[:id])
    authorize! :read, package

    @packages = package.package_payloads.insert_order #order("site asc")
    render json: @packages
  end

  def destroy
    package = PackagePayload.find(params[:id])
    authorize! :destroy, package
    package.delete
    render json: true
  end

  def reorder 
    package = Package.find(params[:id]) 
    authorize! :edit, package 

    params[:payload_ids].each_with_index do |id, index|
      PackagePayload.where(id: id).where(package_id: package.id).update_all( queue_insert_order: index)
    end 
    render json: true
  end 

  def create
    authorize :create, PackagePayload

    PackagePayload.create do |pac|
      pac.package_id = params[:id]
      pac.site       = params[:category]
      pac.payload    = params[:payload_id]
    end
    render json: true
  end
end
