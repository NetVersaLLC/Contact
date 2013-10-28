class PayloadsController < InheritedResources::Base
  respond_to :html, :json
  before_filter      :authenticate_admin!
  # skip_before_filter :verify_authenticity_token
  skip_load_and_authorize_resource
  def index
  end

  def load
    @data = Payload.to_tree(params[:site_id], params[:mode_id])
    render :json => @data
  end
end
