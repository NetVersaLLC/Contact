class Manager < User 
  belongs_to :reseller
  belongs_to :call_center
  has_many   :sales_people
end 
