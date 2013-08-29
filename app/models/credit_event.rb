class CreditEvent < ActiveRecord::Base 
  attr_protected :id 
 # :quantity, :action 

  belongs_to :label
  belongs_to :user  # who did this performed event 
  belongs_to :other, :class_name => Label  # the 'other' involved party 
  belongs_to :transaction_event

  def generate_transaction_code 
    raise 'cant generate a code on a new record' if self.new_record?

    d = created_at
    ((d.year - 2000) * 100000000 + d.yday * 100000 + id % 100000).to_s(36).upcase
  end

end 
