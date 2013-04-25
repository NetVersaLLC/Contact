class Payment < ActiveRecord::Base
  attr_accessor :trans
  attr_accessible :amount, :business_id, :label_id, :status, :transaction_number
  belongs_to :transaction_event
  belongs_to :label
  belongs_to :business
  has_many :transaction_events

  validates :label_id,
    :presence => true

  def self.build(transaction)
    payment             = Payment.new
    payment.trans       = transaction
    payment.label_id    = transaction.label_id
    payment
  end

  def copy_values
    @transaction     = self.trans
    @options         = self.trans.options
    @gateway         = self.trans.label.gateway
  end

  def process
    copy_values
    self.amount   = @transaction.price * 100
    response = self.label.gateway.purchase(self.amount, @transaction.creditcard)

    if response.success?
      self.transaction_number = response.params['transaction_id']
      self.message            = response.message
      self.status             = :success
      save
      self.trans.payment = self
      return true
    else
      self.message            = case response.params['response_reason_code']
        when '78'; 'The card code is invalid. Please check your Security code.'
        else; response.message
      end
      self.status             = :failure
      save
      self.trans.payment = self
      return false
    end
  end

  def refund
    response = self.label.gateway.refund(self.amount, self.transaction_number, {:card_number => @transaction.options[:creditcard][:number] })
    logger.info "Refund response:"
    logger.info response.inspect
    if response.success?
      self.status = :refunded
      save
      return true
    else
      self.status = :refund_failed
      self.message = response.message
      save
      return false
    end
  end

  def is_success?
    self.status.to_sym == :success
  end
end
