class MerchantcircleCategory < SiteCategory
	attr_accessible :name, :parent_id
	acts_as_tree :order => :name
	belongs_to :google_category
	has_many :merchantcircles

  def level1
    if level3.present? 
      parent.parent.name 
    elsif level2.present? 
      parent.name 
    else 
      name 
    end 
  end 

  def level2
    if level3.present? 
      parent.name
    elsif parent.parent.name == 'root' 
      name 
    else 
      nil
    end 
  end 

  def level3
    if parent.name == 'root' || parent.parent.name == 'root' 
      nil
    else 
      name
    end 
  end 
end
