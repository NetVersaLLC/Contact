class Ycphonebook < ClientData
  attr_accessible :email, :ycphonebook_category_id
  virtual_attr_accessor :password
  belongs_to :ycphonebook_category
end
