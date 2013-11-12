class BooboosController < InheritedResources::Base
  load_and_authorize_resource 

  respond_to :html, :json
  actions :all

  def index 
     @q = Booboo.includes(:business).search(params[:q])
     @booboos = @q.result.accessible_by(current_ability).paginate(page: params[:page], per_page: 10)
  end

end 
