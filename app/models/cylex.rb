class Cylex < ClientData  
  attr_accessible :business_id, :created_at, :email, :force_update, :secretsi
  virtual_attr_accessor :password
#  validates :password,
#        :presence => true
end
