class SubscriptionsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @subscription = Subscription.new
    @package      = Package.first
  end

  def edit
    @business = Business.find(params[:id])
    @subscription = @business.subscription
    @package = @subscription.package
    if @subscription == nil
      @subscription = Subscription.new
    end
  end

  def destroy
    @sub = Business.find(params[:id]).subscription
    if @sub.active == false
      flash[:alert] = "Subscription already cancelled."
    else
      if @sub.subscription_code
        resp = ::AUTHORIZENETGATEWAY.cancel_recurring(@sub.subscription_code)
        if resp.success?
          @sub.active = false
          @sub.save!
          flash[:alert] = "Subscription cancelled."
        else
          flash[:alert] = "Error: #{resp.message}"
        end
      else # For coupons
        @sub.active = false
        @sub.save!
        flash[:alert] = "Subscription cancelled."
      end
    end
    redirect_to businesses_path
  end
end
