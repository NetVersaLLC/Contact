class ZipperpageCategory < SiteCategory  
  attr_accessible :name, :parent_id
  acts_as_tree :order => :name
  belongs_to :google_category
  as_many :zipperpages 
end
