class Onlinenetwork < ClientData
  attr_accessible :business_id, :force_update, :secrets
  def has_categories? 
    false
  end 

end
