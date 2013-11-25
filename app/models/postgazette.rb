class Postgazette < ClientData
  attr_accessible :email, :postgazette_category_id
  virtual_attr_accessor :password, :secret_answer
  belongs_to :postgazette_category
end
