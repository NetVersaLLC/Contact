class BooboosController < InheritedResources::Base
  def create
    @booboo             = Booboo.new(params[:booboo])
    @booboo.user_id     = current_user.id if current_user
    @booboo.business_id = params[:business_id]
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
