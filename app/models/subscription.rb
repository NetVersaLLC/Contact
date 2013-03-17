class Subscription < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :package_id, :total
  has_one    :business
  belongs_to :package
  belongs_to :business
  belongs_to :label
  has_one    :transaction

  validates :monthly_fee,
    :presence => true,
    :numericality => true
  validates :package_id, :presence => true
  validates :business_id, :presence => true
  validates :label_id, :presence => true

  def initialize(transaction)
    @transaction     = transaction
    @options         = transaction.options
    self.label_id    = transaction.label_id
    self.business_id = transaction.business_id
  end

  def process
    response = @gateway.recurring(@transaction.monthly_fee, @transaction.credit_card, {
      :interval => {
        :unit => :months,
        :length => 1
      },
      :duration => {
        :start_date => Date.today,
        :occurrences => 9999
      }
    })
    if response.success?
      STDERR.puts "Printing response:"
      STDERR.puts subscription_resp.to_json
      self.message = "Purchase complete!"
      self.subscription_code = response.params['subscription_id']
      subscription.authorizenet_code = purchase_resp.authorization
      subscription.save!
      business                 = Business.new
      business.user_id         = current_user.id
      business.subscription_id = subscription.id
      business.label_id        = current_label.id
      business.save     :validate => false
    end
end
