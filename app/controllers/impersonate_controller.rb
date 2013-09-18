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

  def credentials
    @business = Business.find(params[:business_id])
    @user = @business.user
    @info = {:auth_token => @user.authentication_token, :name => @business.business_name, :subscription_active => @business.subscription.active, :paused => !@business.paused_at.nil?, :payloads => @business.list_payloads}
    respond_to do |format|
      format.json { render json: @info }
    end
  end

end 
