class UsersController < InheritedResources::Base
  load_and_authorize_resource 
  respond_to :html #,:xml, :json
  actions :all

  def index 
    @q = User.search(params[:q])
    @users = @q.result.accessible_by(current_ability).paginate(page: params[:page], per_page: 10)
  end   
end 
