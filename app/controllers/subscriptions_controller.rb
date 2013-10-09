class SubscriptionsController < ApplicationController
  before_filter      :authenticate_user!

  add_breadcrumb 'Subscriptions', :subscriptions_url
  add_breadcrumb 'Edit Subscription', '', only: [:edit, :update]
  add_breadcrumb 'Subscription', '', only: [:show]

  # skip_before_filter :verify_authenticity_token
  def index
    @q = Subscription.joins(:business, :package).search(params[:q])
    @subscriptions = @q.result.accessible_by(current_ability).paginate(page: params[:page], per_page: 10)
  end

  def show
    @subscription = Subscription.find(params[:id])
    authorize! :read, @subscription
  end

  def new
    @subscription = Subscription.new
    @package      = Package.first
  end
  def edit
    @subscription = Subscription.find(params[:id])
    # @business = Business.find(params[:business_id])
    # @subscription = @business.subscription
    # @package = @subscription.package
    # if @subscription == nil
    #   @subscription = Subscription.new
    #   @package = current_label.packages.first
    # end
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
    subscription = Subscription.find(params[:id])
    authorize! :destroy, subscription 

    if subscription.active == false
      flash[:alert] = "Subscription already cancelled."
    else
      ccp = CreditCardProcessor.new(current_label, nil ) 
      subscription = ccp.cancel_recurring(subscription)
      if subscription.status == :cancelled 
        Notification.add_activate_subscription subscription.business 
        flash[:notice] = "Subscription cancelled."
      else
        airbrake_notify StandartException.new("Could not cancel subscription id=#{subscription.id} error=#{subscription.message}")
        flash[:notice] = "An error occured trying to cancel your subscription."
      end
    end
    redirect_to subscriptions_path
  end
end
