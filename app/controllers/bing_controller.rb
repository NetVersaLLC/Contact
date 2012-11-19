class BingController < ApplicationController
  respond_to    :js
  def save_hotmail
    @business = Business.find(params[:business_id])
    if current_user.nil? or @business.user_id != current_user.id
      redirect_to '/', :status => 403
    else
      Bing.create_or_update(@business,
                            :email         => params[:email],
                            :password      => params[:password],
                            :secret_answer => params[:secret_answer])
    end
    respond_with({:status => :ok})
  end

  def bing_category
    render json: BingCategory.categories
  end
end
