class YellowtalkCategory < SiteCategory
  attr_accessible :name, :parent_id
  has_many :yellowtalks
end
