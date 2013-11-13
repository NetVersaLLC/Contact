class Crunchbase < ClientData
  attr_accessible :email
  virtual_attr_accessor :password

  def has_categories? 
    false
  end 

end
