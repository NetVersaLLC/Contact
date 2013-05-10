class Subscription < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessor :trans
  attr_accessible :package_id, :monthly_fee
  has_many   :businesses
  belongs_to :package
  belongs_to :business
  belongs_to :label
  belongs_to :transaction_event
  has_many   :transaction_events

  validates :monthly_fee,
    :presence => true,
    :numericality => true
  validates :package_id, :presence => true
  validates :label_id, :presence => true

  def copy_values
    @transaction     = self.trans
    @options         = self.trans.options
    @gateway         = self.trans.label.gateway
  end

  def self.build(transaction)
    sub              = Subscription.new
    sub.trans        = transaction
    sub.label_id     = transaction.label_id
    sub.package_id   = transaction.package_id
    sub
  end

  def process
    copy_values
    self.monthly_fee = @transaction.monthly_fee * 100

    if self.monthly_fee == 0
      self.active            = true
      self.status            = :success
      self.message           = "Free subscription!"
      save!
      self.trans.subscription = self
      return true
    end

    names            = self.trans.options[:creditcard][:name].split(/\s+/)
    first_name       = names.shift
    last_name        = names.join(" ")
    response = @gateway.recurring(@transaction.monthly_fee, @transaction.creditcard, {
      :interval => {
        :unit   => :months,
        :length => 1
      },
      :duration => {
        :start_date  => Date.today,
        :occurrences => 9999
      },
      :billing_address => {
        :first_name => first_name,
        :last_name  => last_name
      }
    })
    
    if response.success?
      STDERR.puts "Printing response:"
      STDERR.puts response.to_json
      self.active            = true
      self.status            = :success
      self.message           = "Purchase complete!"
      self.subscription_code = response.authorization
      save!
      self.trans.subscription = self
      return true
    else
      self.active            = false
      self.status            = :failed
      self.message           = response.message
      self.trans.subscription = self
      save!
      return false
    end
  end

  def cancel
    copy_values
    response = @gateway.cancel_recurring(self.subscription_code)
    if response.success?
      self.active  = false
      self.status  = :cancelled
      self.message = "Subscription cancelled."
      self.save!
      return true
    else
      self.message = response.message
      self.status  = :failed_cancellation
      self.save!
      return false
    end
  end

  def is_success?
    self.status.to_sym == :success
  end
end
