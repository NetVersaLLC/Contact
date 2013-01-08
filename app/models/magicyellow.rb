class Magicyellow < ClientData
  attr_accessible :business_id, :created_at, :email, :force_update, :updated_at
  virtual_attr_accessor :password
  validates :password,
	:presence => true
end
