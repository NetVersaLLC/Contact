class Zipperpage < ClientData
  attr_accessible :email
  virtual_attr_accessor :password 
  belongs_to            :zipperpage_category 
end
