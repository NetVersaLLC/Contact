class TransactionEvent < ActiveRecord::Base
  attr_accessor   :options, :creditcard, :mypackage
  attr_accessible :business_id, :label_id, :coupon_id, :payment_id, :package_id, :status, :subscription_id, :message
  belongs_to :label
  belongs_to :business
  belongs_to :coupon
  belongs_to :payment
  belongs_to :subscription
  belongs_to :package
  has_many :payments
  has_many :subscriptions

  validates :label_id,
    :presence => true
  validates :package_id,
    :presence => true

  def self.build(options, package, label)
    transaction = TransactionEvent.new
    transaction.options   = options
    transaction.mypackage = package
    transaction.label     = label
    transaction.coupon    = Coupon.where(:label_id => label.id, :code => options[:coupon_code]).first
    transaction.mypackage.apply_coupon(@coupon)
    transaction.price          = transaction.mypackage.price
    transaction.original_price = transaction.mypackage.original_price
    transaction.monthly_fee    = transaction.mypackage.monthly_fee
    transaction.saved          = transaction.mypackage.saved
    transaction.package_id     = package.id
    transaction.label_id       = label.id
    transaction
  end

  def process
    @creditcard = ActiveMerchant::Billing::CreditCard.new(@options[:creditcard])
    if self.monthly_fee == 0 and self.price == 0
      # Skip the next bit, not sure a clearer way to put this
    else
      STDERR.puts "Self: #{self.monthly_fee}: #{self.price}"
      unless @creditcard.valid?
        message = "Credit card is not valid"
        @creditcard.errors.select{|k,v| !v.empty? }.each { |k,v|
          message = "#{message}<br>- #{k.humanize} : #{v.join}"
        }
        self.message = message.html_safe
        self.status  = :failure
        save
        return false
      end
    end
    ActiveRecord::Base.transaction do
      @payment = Payment.build(self)
      payment_result = @payment.process()
      self.payment    = @payment
      self.payment_id = @payment.id
      if @payment.is_success?
        @sub = Subscription.build(self)
        subscription_result = @sub.process()
        
        if @sub.is_success?
          self.subscription    = @sub
          self.subscription_id = @sub.id
          self.message         = "Purchase complete"
          self.status          = :success
        else
          @payment.refund()
          self.message           = case subscription_result.params['code']
            when "E00012"; "<strong>Subscription Error!</strong><br>An error occurred while processing subscription of payment. You have submitted a duplicate of Subscription. Please check your Credit card number and try again.".html_safe
            else; @sub.message
          end
          self.status            = @sub.status
          self.subscription      = @sub
          self.subscription_id   = @sub.id
          @sub.transaction_event = self
          @sub.save
          @payment.transaction_event = self
          @payment.save
          return false
        end
      else
        self.message    = @payment.message
        self.status     = @payment.status
        self.payment    = @payment
        self.payment_id = @payment.id
        save
        @payment.transaction_event = self
        @payment.save
        return false
      end
    end
    save
    @sub.transaction_event = self
    @sub.save
    @payment.transaction_event = self
    @payment.save
    return true
  end

  def is_success?
    self.status == :success
  end

  def setup_business(business)
    self.business = business
    save
    pay = self.payment
    pay.business = business
    pay.save
    sub = self.subscription
    sub.business = business
    sub.save
  end
end
