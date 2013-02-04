class Staylocal < ClientData 
  attr_accessible :business_id, :created_at, :email, :force_update, :secrets
  virtual_attr_accessor :password
  validates :password,
        :presence => true
end
