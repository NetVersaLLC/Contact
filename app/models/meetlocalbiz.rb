class Meetlocalbiz < ClientData
  attr_accessible :email, :username
  virtual_attr_accessor :password
  belongs_to :meetlocalbiz_category
  
end
