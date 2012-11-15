class SubscriptionsController < ApplicationController
  def index
  end

  def new
    @subscription = Subscription.new
  end

  def create
    sub           = params['subscription']
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
    @subscription.authorizenet_code = response.status

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
      response = ::AUTHORIZENETGATEWAY.recurring(package.price, credit_card, {
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
      if response.success?
        flash[:notice] = "Purchase complete!"
        @subscription.save
        business                 = Business.new
        business.user_id         = current_user.id
        business.subscription_id = @subscription.id
        business.save     :validate => false
        redirect_to edit_business_path(business)
      else
        flash[:alert] = "Error: #{response.message}"
        render :action => 'new'
      end
    else
      flash[:alert] = "Error: Credit card is invalid."
      render :action => 'new'
    end
  end

  def destroy
    @sub = Subscription.find(params[:id])
  end
end
