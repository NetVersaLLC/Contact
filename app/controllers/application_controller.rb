class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :impersonating_user, :breadcrumbs

  def breadcrumbs
    @breadcrumbs ||= []
  end 

  def current_label
    label = Label.where(:domain => request.host).first
    unless label
      label = Label.first
      #raise "a label to match the domain [#{request.host}] could not be found"
    end
    label
  end
 
  def impersonating_user 
    return nil unless session[:impersonator_id]
    User.find session[:impersonator_id]
  end 

  def check_admin_role
    return if current_user.reseller?
    flash[:notice] = "You need to be an admin to access this part of the application"
    redirect_to root_path
  end

  def authenticate_admin!
    check_admin_role
  end

  rescue_from CanCan::AccessDenied do |exception|
    #redirect_to root_url, :error => exception.message
    sign_out current_user 
    redirect_to new_user_session_url, :alert => exception.message
  end

  # def after_sign_in_path_for resource
  #   if resource.admin? || resource.reseller?
  #     admin_root_url
  #   else
  #     root_url
  #   end
  # end

  # def current_ability
  #   @current_ability ||= Ability.new(current_admin_user)
  # end 
  protected 
    def add_breadcrumb name, url = ''
      breadcrumbs << [name, url]
    end 

    def self.add_breadcrumb name, url, options = {}
      before_filter options do |controller| 
        controller.send(:add_breadcrumb, name, url)
      end 
    end 
end
