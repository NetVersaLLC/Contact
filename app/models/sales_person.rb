class SalesPerson < User 

  belongs_to :manager 
  has_many   :businesses

end 
