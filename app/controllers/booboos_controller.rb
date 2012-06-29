class BooboosController < InheritedResources::Base
  skip_before_filter :verify_authenticity_token
  def create
    @booboo             = Booboo.new
    @booboo.user_id     = current_user.id if current_user
    @booboo.business_id = params[:business_id]
    @booboo.message     = params[:message]
    @booboo.user_agent  = request.env['HTTP_USER_AGENT']
    @booboo.ip          = request.remote_ip
    respond_to do |format|
      if @booboo.save
        format.json { render json: @booboo, status: :created, location: @booboo }
      else
        format.json { render json: @booboo.errors, status: :unprocessable_entity }
      end
    end
  end
end
