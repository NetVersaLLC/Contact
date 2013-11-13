class Citydata < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  belongs_to :citydata_category
  def has_categories? 
    false
  end 

  
end
