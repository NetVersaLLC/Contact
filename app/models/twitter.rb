class Twitter < ClientData
  attr_accessible :username
  virtual_attr_accessor :password
  validates :username,
            :presence => true,
            :format => { :with => /^\w{1,15}$/ }
  validates :password,
            :presence => true
end
