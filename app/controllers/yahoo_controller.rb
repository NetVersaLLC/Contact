class YahooController < ApplicationController
  def save_email
    @business = Business.find(params[:business_id])
    if current_user.nil? or @business.user_id != current_user.id
      redirect_to '/', :status => 403
    else
      Yahoo.create_or_update(@business,
                            :email     => params[:email],
                            :password  => params[:password],
                            :secret1   => params[:secret1],
                            :secret2   => params[:secret2])
    end

  end
  def yahoo_category
    render json: YahooCategory.categories
  end
end
