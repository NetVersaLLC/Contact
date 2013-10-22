class Subscription < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessor :trans
  attr_accessible :package_id, :monthly_fee, :message, :status 
  has_one   :business
  belongs_to :package
  #belongs_to :business
  belongs_to :label
  belongs_to :transaction_event
  has_many   :transaction_events

  validates :monthly_fee,
    :presence => true,
    :numericality => true
  validates :package_id, :presence => true
  validates :label_id, :presence => true

  def is_success?
    self.status.to_sym == :success
  end
end
