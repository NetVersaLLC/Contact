class N16mall < ClientData
  attr_accessible :email, :n16mall_category_id
  virtual_attr_accessor :password, :secret_answer
  belongs_to :n16mall_category
end
