class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_label
    label = Label.where(:domain => request.host).first
    unless label
      label = Label.first
    end
    label
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end 
end
