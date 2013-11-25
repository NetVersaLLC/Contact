class Bizhyw  < ClientData 
  attr_accessible :email
  virtual_attr_accessor :password
  belongs_to            :bizhyw_category
end
