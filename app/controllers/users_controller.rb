class UsersController < InheritedResources::Base
  load_and_authorize_resource 
  respond_to :html #,:xml, :json
  actions :all
  add_breadcrumb 'Users', :users_url
  add_breadcrumb  'New User', '', only: [:new, :create]
  add_breadcrumb  'Edit User', '', only: [:edit, :update]
  add_breadcrumb  'User', '', only: [:show]

  def index 
    @q = User.search(params[:q])
    @users = @q.result.accessible_by(current_ability).paginate(page: params[:page], per_page: 10)
  end   



  def update 
    @user = User.find(params[:id])
    authorize! :update, @user

    if params[:user][:password].blank?
      params[:user].delete(:password) 
      params[:user].delete(:password_confirmation)
    end 

    if current_user.admin? 
      saved = @user.update_attributes( params[:user], as: :admin) 
    else 
      saved = @user.update_attributes( params[:user] )
    end 
    if saved 
      flash[:notice] = "User updated successfully." 
      redirect_to users_url
    else 
      flash[:alert] = "An error occurred trying to save your changes. #{@user.errors.full_messages}"
      render :edit
    end 
  end 

end 
