class YelpCategory < SiteCategory
  acts_as_tree :order => :name
  belongs_to :google_category
  has_many :yelp
end
