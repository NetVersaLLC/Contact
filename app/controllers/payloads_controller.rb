class PayloadsController < ApplicationController
  skip_load_and_authorize_resource
  def index
    if current_user.reseller?
      @payloads = Payload.list(params[:id])
      render json: @payloads
    else
      error = {:error => :access_denied}
      render json: error, :status => 403
    end
  end
end
