class GoogleController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def save_email
    @business = Business.find(params[:business_id])
    if current_user.nil? or @business.user_id != current_user.id
      redirect_to '/', :status => 403
    else
      Google.create_or_update(@business,
                            :email         => params[:email],
                            :password      => params[:password])
    end
  end
end
