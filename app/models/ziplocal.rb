class Ziplocal  < ClientData 
  attr_accessible :email
  virtual_attr_accessor :password
  belongs_to            :ziplocal_category 
end
