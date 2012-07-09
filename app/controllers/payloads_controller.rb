class PayloadsController < InheritedResources::Base
  before_filter :authenticate_user!
  def index
    @payloads = Payload.where(:status => 'enabled')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payloads }
    end
  end
end
