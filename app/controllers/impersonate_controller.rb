class ImpersonateController < ApplicationController 
  def index
    @users = User.accessible_by(current_ability).where(access_level: User.owner).order('email asc')
  end 

  def new 
    user = User.find(params[:id]) 
    authorize! :edit, user 
    session[:impersonator_id] = current_user.id 
    sign_in user

    redirect_to root_path
  end 

  def revert 
    if session[:impersonator_id] 
      sign_in User.find(session[:impersonator_id]) 
      session[:impersonator_id] = nil
    end 

    redirect_to admin_root_url
  end 

end 
