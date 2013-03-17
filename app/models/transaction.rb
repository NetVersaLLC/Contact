class Transaction < ActiveRecord::Base
  attr_accessor   :options, :creditcard, :mypackage
  attr_accessible :business_id, :label_id, :coupon_id, :payment_id, :package_id, :status, :subscription_id
  belongs_to :label
  belongs_to :business
  belongs_to :coupon
  belongs_to :payment
  belongs_to :subscription
  belongs_to :package
  has_one :payment
  has_one :subscription

  validates :label_id,
    :presence => true
  validates :business_id,
    :presence => true
  validates :package_id,
    :presence => true

  def initialize(options, package, label, business = Business.new)
    @options   = options
    @mypackage = package
    @label     = label
    @business  = business
    @coupon    = Coupon.where(:label_id => label.id, :code => options[:coupon_code]).first
    @mypackage.apply_coupon(@coupon)
    self.price          = @mypackage.price
    self.original_price = @mypackage.original_price
    self.monthly_fee    = @mypackage.monthly_fee
    self.saved          = @mypackage.saved
    self.package_id     = package.id
    self.label_id       = label.id
    if @coupon
      self.coupon_id    = @coupon.id
    end
    if business.id
      self.business_id  = business.id
    end
  end

  def process
    @creditcard = ActiveMerchant::Billing::CreditCard.new(@options[:creditcard])
    unless @creditcard.valid?
      self.message = "Credit card is not valid"
      self.status  = :failure
      save
      return false
    end
    ActiveRecord::Base.transaction do
      @payment = Payment.new(self)
      @payment.process()
      self.payment_id = @payment.id
      if @payment.is_success?
        @sub = Subscription.new(self)
        @sub.process()
        if @sub.is_success?
          self.subscription_id = @sub.id
          self.message         = "Purchase complete"
          self.status          = :success
        else
          @payment.refund()
          self.message = @sub.message
          self.status  = @sub.status
          return false
        end
      else
        self.message = @payment.message
        self.status  = @payment.status
        return false
      end
    end
    return true
  end

  def is_success?
    self.status == :success
  end
end
