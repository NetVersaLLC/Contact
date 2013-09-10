class CreditEvent < ActiveRecord::Base 
  after_create :generate_transaction_code
  attr_protected :id 
 # :quantity, :action 

  belongs_to :label
  belongs_to :user  # who did this performed event 
  belongs_to :other, :class_name => Label  # the 'other' involved party 
  belongs_to :transaction_event
  belongs_to :subscription

  private 
    def generate_transaction_code 
      d = created_at
      self.update_attribute(:transaction_code, ((d.year - 2000) * 100000000 + d.yday * 100000 + id % 100000).to_s(36).upcase )
    end

end 
