class TransactionEvent < ActiveRecord::Base
  attr_accessor   :options, :creditcard, :mypackage
  attr_accessible :business_id, :label_id, :coupon_id, :payment_id, :package_id, :status, :subscription_id
  attr_accessible :other_label_id, :message, :charge_amount, :post_available_balance, :action

  belongs_to :label
  belongs_to :other_label, class_name: "Label"  # label to label transactions, such as transferring funds 
  belongs_to :business
  belongs_to :coupon
  belongs_to :payment
  belongs_to :subscription
  belongs_to :package
  has_many :payments
  has_many :subscriptions

  validates :label_id,
    :presence => true
  #validates :package_id, :presence => true


  def is_success?
    self.status == :success
  end
end
