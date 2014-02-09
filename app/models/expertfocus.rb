class Expertfocus < ClientData
  attr_accessible :expertfocus_category_id, :email
  virtual_attr_accessor :password
  belongs_to :expertfocus_category
end
