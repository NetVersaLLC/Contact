class Nationalwebdir < ClientData
  attr_accessible :email, :nationalwebdir_category_id
  virtual_attr_accessor :password
  belongs_to :nationalwebdir_category
end
