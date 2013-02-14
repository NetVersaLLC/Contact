class PackagesController < ApplicationController
  def index
    if current_user.reseller?
      @packages = Package.find(params[:id]).package_payloads
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
