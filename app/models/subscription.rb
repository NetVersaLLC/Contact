class Subscription < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessor   :card_number, :card_type, :exp_year, :exp_month, :cvv, :coupon_code
  attr_accessible :card_number, :card_type, :exp_year, :exp_month, :cvv, :coupon_code
  attr_accessible :address,     :address2, :affiliate_id, :city, :first_name, :last_name, :package_id, :package_name, :phone, :state, :tos_agreed, :total, :zip
  has_one :business
  belongs_to :package
  belongs_to :coupon

  validates :total,
    :presence => true,
    :numericality => true
  validates :package_id, :presence => true
  validates :first_name, :presence => true
  validates :last_name,  :presence => true
  validates :address,    :presence => true
  validates :city,       :presence => true
  validates :state,      :presence => true
  validates :zip,        :presence => true


  def self.years
    (Time.now.year .. Time.now.year + 10).to_a
  end

  def self.months
    months = {}
    Date::MONTHNAMES[1..12].each_with_index do |e,i|
      months[e] = (i + 1).to_s
    end
    months
  end

  def self.cards
    x = { :visa => 'Visa',
      :master => 'Master Card',
      :american_express => 'American Express',
      :discover => 'Discover' }
    x.invert
  end

  def self.create_subscription(sub, business_id)
    business = nil
    @subscription    = Subscription.create do |s|
      s.package_id   = Package.first.id
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
    if business_id and business_id != ''
      business = Business.find(business_id)
    else
      business = Business.new
    end
    logger.info "Adding subscription #{@subscription.id} to business #{business.id}"
    business.user_id         = current_user.id
    business.subscription_id = @subscription.id
    business.save            :validate => false
    return business
  end

  def self.copy_subscription(sub,package)
    subscription = Subscription.new
    subscription.package_id = package.id
    subscription.total      = package.monthly_fee
    subscription.intial_fee = package.price
    subscription.first_name = sub['first_name']
    subscription.last_name  = sub['last_name']
    subscription.address    = sub['address']
    subscription.address2   = sub['address2']
    subscription.city       = sub['city']
    subscription.state      = sub['state']
    subscription.zip        = sub['zip']
    subscription.tos_agreed = true
    subscription.active     = true
    subscription.card_type  = sub['card_type']
    subscription.card_number= sub['card_number']
    subscription.cvv        = sub['cvv']
    subscription.exp_month  = sub['exp_month']
    subscription.exp_year   = sub['exp_year']
    subscription
  end

  def self.copy_card_info(sub)
    credit_card = ActiveMerchant::Billing::CreditCard.new(
      :type               => sub['card_type'],
      :number             => sub['card_number'],
      :verification_value => sub['cvv'],
      :month              => sub['exp_month'],
      :year               => sub['exp_year'],
      :first_name         => sub['first_name'],
      :last_name          => sub['last_name']
    )
    credit_card
  end

  def self.get_gateway(coupon)
    ActiveMerchant::Billing::Base.mode = :test
    gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
      # iwntbbnprn2
      #
      :login    => "8e3UfTHKM9d2",
      :password => "5B7t5V6S65m3WkdU",
      :test     => true
    )
    if Rails.env == :production or Rails.env == 'production'
      if coupon
        gateway = coupon.get_gateway
        ActiveMerchant::Billing::Base.mode = :production
      end
    end
    gateway
  end
end
