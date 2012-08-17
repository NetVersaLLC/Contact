class Account < ClientData
  attr_accessible :address, :email, :force_update, :port, :username
  virtual_attr_accessor :password
  validates :address,
            :presence => true
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :port,
            :presence => true,
            :format => { :with => /^\s*\d+\s*$/ }
  validates :username,
            :presence => true
  validates :password,
            :presence => true
end
