class YellowwizCategory < SiteCategory
  attr_accessible :parent_id, :name
  has_many :yellowwizs
  def has_categories? 
    false
  end 

end
