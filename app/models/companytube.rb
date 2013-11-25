class Companytube < ClientData
  attr_accessible :username,:email
  virtual_attr_accessor :password
end
