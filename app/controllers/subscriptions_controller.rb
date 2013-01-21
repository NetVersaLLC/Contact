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
    if @subscription == nil
      @subscription = Subscription.new
    end
  end

  def create
    sub    = params['subscription']
    coupon = Coupon.where(:code => sub['coupon_code']).first
    logger.info "Coupon: #{coupon.inspect}"
    if coupon != nil and coupon.percentage_off == 100
      flash[:notice] = "Subscription started and coupon applied!"
      business       = Subscription.create_subsciption(sub, params[:business_id])
      redirect_to edit_business_path(business)
      return
    end
    package      = Package.apply_coupon(sub['package_id'], coupon)

    logger.info "Creating subscription..."

    subscription = Subscription.copy_subscription(sub,package)
    credit_card  = Subscription.copy_card_info(sub)
    gateway      = Subscription.get_gateway(coupon)
    if credit_card.valid?
      logger.info "Creating purchase..."
      resp = gateway.purchase(package.price, credit_card, {
        :billing_address => {
          :first_name => sub['first_name'],
          :last_name  => sub['last_name'],
          :address1   => sub['address'] + ' ' + sub['address2'],
          :city       => sub['city'],
          :state      => sub['state'],
          :country    => 'United States',
          :zip        => sub['zip']
        }
      })
      logger.info resp.inspect
      if resp.success?
        logger.info "Creating recurring..."
        resp = gateway.recurring(package.monthly_fee, credit_card, {
          :interval => {
            :unit => :months,
            :length => 1
          },
          :duration => {
            :start_date => Date.today,
            :occurrences => 9999
          },
          :billing_address => {
            :first_name => sub['first_name'],
            :last_name  => sub['last_name'],
            :address1   => sub['address'] + ' ' + sub['address2'],
            :city       => sub['city'],
            :state      => sub['state'],
            :country    => 'United States',
            :zip        => sub['zip']
        }})
      end
      if resp.success?
        logger.info "Printing response:"
        logger.info resp.to_json
        flash[:notice] = "Purchase complete!"
        @subscription.authorizenet_code = resp.authorization
        @subscription.save!
        business                 = Business.new
        business.user_id         = current_user.id
        business.subscription_id = @subscription.id
        business.save     :validate => false
        redirect_to edit_business_path(business)
      else
        resp = gateway.credit(package.price, credit_card)
        flash[:alert] = "Error: #{resp.message}"
        redirect_to new_subscription_path
      end
    else
      flash[:alert] = "Error: Credit card is invalid."
      redirect_to new_subscription_path
    end
  end

  def update
    @business = Business.find(params[:business_id])
    sub       = params['subscription']
    coupon = Coupon.where(:code => sub['coupon_code']).first
    if coupon != nil
      flash[:notice]   = "Coupon applied and subscription complete!"
      @subscription    = Subscription.create do |s|
        s.package_id   = Package.first
        s.package_name = Package.first.name
        s.total        = Package.first.price
        s.first_name   = sub['first_name']
        s.last_name    = sub['last_name']
        s.address      = sub['address']
        s.address2     = sub['address2']
        s.city         = sub['city']
        s.state        = sub['state']
        s.zip          = sub['zip']
        s.coupon_id    = coupon.id
        s.tos_agreed   = true
        s.active       = true
      end
      @subscription.save!
      @business.user_id         = current_user.id
      @business.subscription_id = @subscription.id
      @business.save              :validate => false
      redirect_to edit_business_path(@business)
      return
    end
    package       = Package.find( sub['package_id'] )
    @subscription = Subscription.new
    @subscription.package_id = package.id
    @subscription.total      = package.price
    @subscription.first_name = sub['first_name']
    @subscription.last_name  = sub['last_name']
    @subscription.address    = sub['address']
    @subscription.address2   = sub['address2']
    @subscription.city       = sub['city']
    @subscription.state      = sub['state']
    @subscription.zip        = sub['zip']
    @subscription.tos_agreed = true
    @subscription.active     = true

    # Copy values over to re-render the form in case of
    # an error.
    @subscription.card_type   = sub['card_type']
    @subscription.card_number = sub['card_number']
    @subscription.cvv         = sub['cvv']
    @subscription.exp_month   = sub['exp_month']
    @subscription.exp_year    = sub['exp_year']

    credit_card = ActiveMerchant::Billing::CreditCard.new(
      :type               => sub['card_type'],
      :number             => sub['card_number'],
      :verification_value => sub['cvv'],
      :month              => sub['exp_month'],
      :year               => sub['exp_year'],
      :first_name         => sub['first_name'],
      :last_name          => sub['last_name']
    )
    if credit_card.valid?
      resp = ::AUTHORIZENETGATEWAY.recurring(package.price, credit_card, {
        :interval => {
          :unit    => :months,
          :length  => 1
        },
        :duration => {
          :start_date  => Date.today,
          :occurrences => 9999
        },
        :billing_address => {
          :first_name => sub['first_name'],
          :last_name  => sub['last_name'],
          :address1   => sub['address'] + ' ' + sub['address2'],
          :city       => sub['city'],
          :state      => sub['state'],
          :country    => 'United States',
          :zip        => sub['zip']
      }})
      if resp.success?
        logger.info "Printing response:"
        logger.info resp.to_json
        flash[:notice] = "Purchase complete!"
        @subscription.authorizenet_code = resp.authorization
        @subscription.save!
        business                 = @business
        business.user_id         = current_user.id
        business.subscription_id = @subscription.id
        business.save     :validate => false
        redirect_to edit_business_path(business)
      else
        flash[:alert] = "Error: #{resp.message}"
        redirect_to edit_subscription_path(@business.id)
      end
    else
      flash[:alert] = "Error: Credit card is invalid."
      redirect_to edit_subscription_path(@business.id)
    end
  end

  def destroy
    @sub = Business.find(params[:id]).subscription
    if @sub.active == false
      flash[:alert] = "Subscription already cancelled."
    else
      if @sub.authorizenet_code
        resp = ::AUTHORIZENETGATEWAY.cancel_recurring(@sub.authorizenet_code)
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
