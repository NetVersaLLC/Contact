class Yellowwiz < ClientData
  attr_accessible :email, :username
  virtual_attr_accessor :password
  belongs_to :yellowtalk_category
  def has_categories? 
    false
  end
end
