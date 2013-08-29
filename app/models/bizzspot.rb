class Bizzspot < ClientData
  attr_accessible :email, :username
  virtual_attr_accessor :password  
end