class Bigwigbiz < ClientData
  attr_accessible :email, :bigwigbiz_category_id
  virtual_attr_accessor :password
  belongs_to :bigwigbiz_category
end
