class Discoverourtown < ClientData
  attr_accessible :business_id, :created_at, :email, :force_update, :secrets, :updated_at
  virtual_attr_accessor :password
end