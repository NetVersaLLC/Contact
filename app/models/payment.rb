class Payment < ActiveRecord::Base
  attr_accessor :trans
  attr_accessible :amount, :business_id, :label_id, :status, :transaction_number, :message
  belongs_to :transaction_event
  belongs_to :label
  belongs_to :business
  has_many :transaction_events

  validates :label_id,
    :presence => true


  def is_success?
    self.status.to_sym == :success
  end
end
