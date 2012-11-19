class BingController < ApplicationController
  respond_to    :js
  def save_hotmail
    @business = Business.find(params[:business_id])
    if current_user.nil? or @business.user_id != current_user.id
      redirect_to '/', :status => 403
    else
      bing = @business.bings.first
      bing.email           = params[:email]
      bing.password        = params[:password]
      bing.secret_answer   = params[:secret_answer]
      bing.save
    end
    render json: {'status' => 'success'}
  end

  def bing_category
    render json: BingCategory.categories
  end
end
