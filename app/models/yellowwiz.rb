class Yellowwiz < Clientdata
  attr_accessible :email, :username
  virtual_attr_accessible :password
  belongs_to :yellowtalk_category
end