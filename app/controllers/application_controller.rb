class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

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
    return unless current_user.is_a? Administrator
    flash[:notice] = "You need to be an admin to access this part of the application"
    redirect_to root_path
  end

  def authenticate_admin!
    check_admin_role
  end

  def authenticate_reseller!
    return unless current_user.is_a? Administrator
    flash[:notice] = "You need to be an admin to access this part of the application"
    redirect_to root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :error => exception.message
    # sign_out current_user 
    #redirect_to new_user_session_url, :alert => exception.message
  end

  protected 
    def authenticate_user_from_token!
      user_token = params[:auth_token].presence
      user       = user_token && User.find_by_authentication_token(user_token)

      if user 
        sign_in user, store: false  # dont store session so that the token is needed on every request
      end 
    end 

    def add_breadcrumb name, url = ''
      breadcrumbs << [name, url]
    end 

    def self.add_breadcrumb name, url, options = {}
      before_filter options do |controller| 
        controller.send(:add_breadcrumb, name, url)
      end 
    end 
end
