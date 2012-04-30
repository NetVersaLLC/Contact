class Yelp < ClientData
  attr_accessible :email, :yelp_category_id
  virtual_attr_accessor :password
  belongs_to :yelp_category
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
            :presence => true
end
