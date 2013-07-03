class Yellowtalk < ClientData
  attr_accessible :email, :username
  virtual_attr_accessor :password
  belongs_to :yellowtalk_category
end
