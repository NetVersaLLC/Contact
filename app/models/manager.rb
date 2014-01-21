class Manager < User 
  belongs_to :reseller
  has_many   :sales_people
end 
