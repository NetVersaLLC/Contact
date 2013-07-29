class SubscriptionsController < ApplicationController
  before_filter      :authenticate_user!
  # skip_before_filter :verify_authenticity_token
  def index
  end

  def show
  end

  def new
    @subscription = Subscription.new
    @package      = Package.first
  end
  def edit
    @business = Business.find(params[:business_id])
    @subscription = @business.subscription
    @package = @subscription.package
    if @subscription == nil
      @subscription = Subscription.new
      @package = current_label.packages.first
    end
    @creditcard = CreditCard.new
  end
  def update 
    # set up a subscription
    @business = Business.find(params[:business_id])
    @package = Package.find(params[:package_id]) 

    lb = LabelProcessor.new current_label 
    transaction_event = lb.renew_business_subscription(current_user, @package, @business, params[:creditcard]) 

    if transaction_event.status == :success
      flash[:notice] = 'Subscription updated' 
      @business.notifications.activate_subscription.delete_all
      redirect_to business_path @business
    else 
      @error = "Subscription failed. #{transaction_event.message}"
      render :edit
    end 
  end 

  def destroy
    business = Business.find(params[:id])
    @sub = business.subscription
    if @sub.active == false
      flash[:alert] = "Subscription already cancelled."
    else
      ccp = CreditCardProcessor.new(current_label, nil ) 
      @sub = ccp.cancel_recurring(@sub)
      if @sub.status == :cancelled 
        Notification.add_activate_subscription business 
        flash[:alert] = "Subscription cancelled."
      else
        flash[:alert] = "Error: #{@sub.message}"
      end
    end
    redirect_to businesses_path
  end
end
