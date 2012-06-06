class Kudzu < ClientData
  attr_accessible :username
  virtual_attr_accessor :password
  validates :username,
            :presence => true
  validates :password,
            :presence => true
end
