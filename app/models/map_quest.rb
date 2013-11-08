class MapQuest < ClientData
  attr_accessible       :email
  virtual_attr_accessor :password

  def has_categories? 
    false
  end
#  validates :email,
#            :presence => true,
#            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
#  validates :password,
#            :presence => true
end
