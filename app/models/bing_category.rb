class BingCategory < SiteCategory
  attr_accessible :name, :name_path, :parent_id
  acts_as_tree :order => :name
  belongs_to :google_category
  has_many :bings
end
