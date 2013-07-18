class YellowwizCategory < SiteCategory
  attr_accessible :parent_id, :name
  has_many :yellowwizs
end