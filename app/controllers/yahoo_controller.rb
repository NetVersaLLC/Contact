class YahooController < ApplicationController
  def save_email
    @business = Business.find(params[:business_id])
    if current_user.nil? or @business.user_id != current_user.id
      redirect_to '/', :status => 403
    else
      yahoo = @business.yahoos.first
      yahoo.email     = params[:email]
      yahoo.password  = params[:password]
      yahoo.secret1   = params[:secret1]
      yahoo.secret2   = params[:secret2]
      yahoo.save
    end
    render json: {'status' => 'success'}
  end
  def yahoo_category
    render json: YahooCategory.categories
  end
end
