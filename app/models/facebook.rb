class Facebook < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
            :presence => true
  def Facebook.data
    hash = Business.find_by_user_id(self.user_id).to_hash
    hash[:email] = self.email
    hash[:password] = self.password
  end
end
