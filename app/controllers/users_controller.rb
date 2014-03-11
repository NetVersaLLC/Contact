class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:token]
  skip_load_and_authorize_resource only: :token

  respond_to :html, :json

  add_breadcrumb 'Users', :users_url
  add_breadcrumb  'New User', '', only: [:new, :create]
  add_breadcrumb  'Edit User', '', only: [:edit, :update]
  add_breadcrumb  'User', '', only: [:show]

  
  def index 
    @q = User.search(params[:q])
    @users = @q.result.includes(:businesses).accessible_by(current_ability).paginate(page: params[:page], per_page: 10)
  end   

  def new 
    @user = new_user_from_role params[:r]
    @user.label_id = current_label.id

    authorize! :create, User
  end 

  def create 
    user = new_user_from_role params[:role]
    user.label_id = current_label.id 

    authorize! :create, user

<<<<<<< HEAD
    # user.call_center_id = current_user.call_center_id
=======
>>>>>>> bb8b82e25eca36bda96c1b29dc6987c688df66e0

    user.update_attributes( params[:user] )
    user.save!

    if user.kind_of?(SalesPerson)
      user.update_attribute(:call_center_id, user.manager.call_center_id)
    end 

    flash[:notice] = user.full_name + " created." 
    redirect_to new_user_url
  end 

  def show 
    @user = User.find(params[:id]) 
    authorize! :read, @user
  end 

  def edit 
    @user = User.find(params[:id]) 
    authorize! :update, @user
  end 

  def update 
    @user = User.find(params[:id])
    authorize! :update, @user

    if params[:user][:password].blank?
      params[:user].delete(:password) 
      params[:user].delete(:password_confirmation)
    end 

    if current_user.is_a?(Administrator) || current_user.is_a?(Reseller)
      saved = @user.update_attributes( params[:user], as: :admin) 
    else 
      saved = @user.update_attributes( params[:user] )
    end 

    sign_in(@user, bypass: true) if @user.id == current_user.id  # devise signs out the user when changing the password. 

    if saved 
      flash[:notice] = "User updated successfully." 
      redirect_to user_path @user
    else 
      flash[:alert] = "An error occurred trying to save your changes. #{@user.errors.full_messages}"
      render :edit
    end 
  end 
  def destroy 
    user = User.find(params[:id])
    authorize! :destroy, user

    user.delete
    flash[:notice] = "User has been deleted."
    redirect_to users_url
  end

  def token
    user = User.find_by_email( params[:email] )
    if user.nil? 
      render :json => { success: false, message: 'error with your email or password', status: 401 } 
    end 

    if user.valid_password?( params[:password] )
      render :json => { success: true, auth_token: user.authentication_token, business_id: user.businesses.first.id } 
    else 
      render :json => { success: false, message: 'error with your email or password', status: 401 } 
    end 
  end 

private 
  def new_user_from_role role_name
    role = User::ROLES.select{ |r| r == role_name }.first || User::ROLES.first
    role.gsub(/ /, "").constantize.new 
  end 

end 
