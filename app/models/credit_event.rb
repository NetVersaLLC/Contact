class CreditEvent < ActiveRecord::Base 
  attr_accessible :quantity, :action 

  belongs_to :label
  belongs_to :user  # who did this performed event 
  belongs_to :other, :class_name => Label  # the 'other' involved party 

  validate :action, 
    :inclusion => { :in => %w(transfer_to transfer_from purchase) }, 
    :message => "%{value} is an unknown action" 
end 
