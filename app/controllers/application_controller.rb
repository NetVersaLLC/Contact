class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_label
    label = Label.where(:domain => request.host).first
    unless label
      label = Label.first
    end
    label
  end


  def check_admin_role
    return if current_user.reseller?
    flash[:notice] = "You need to be an admin to access this part of the application"
    redirect_to root_path
  end


  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_url, :alert => exception.message
  # end

  # def current_ability
  #   @current_ability ||= Ability.new(current_admin_user)
  # end 
end
