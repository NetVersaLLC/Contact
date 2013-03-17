class Payment < ActiveRecord::Base
  attr_accessible :amount, :business_id, :label_id, :transaction_id, :status, :transaction_number
  belongs_to :transaction
  belongs_to :label
  belongs_to :business
  has_one :transaction

  validates :label_id,
    :presence => true
  validates :business_id,
    :presence => true

  def initialize(transaction)
    @transaction     = transaction
    @options         = transaction.options
    self.label_id    = transaction.label_id
    self.business_id = transaction.business_id
  end

  def process
    self.amount   = @transaction.price * 100
    response = self.label.gateway.purchase(self.amount, @transaction.creditcard)

    if response.success?
      self.transaction_number = response.params['transaction_id']
      self.message            = response.message
      self.status             = :success
    else
      self.message            = response.message
      self.status             = :failure
    end
    save
  end

  def refund
    response = self.label.gateway.refund(self.amount, self.transaction_number, {:card_number => @transaction.options['card_number'] })
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
