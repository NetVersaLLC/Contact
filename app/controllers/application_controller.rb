class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      edit_business_path(current_user.id)
    else
      super
    end
  end

end
