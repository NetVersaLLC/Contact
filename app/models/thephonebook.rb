class Thephonebook  < ClientData 
  attr_accessible :email
  virtual_attr_accessor :password
end
