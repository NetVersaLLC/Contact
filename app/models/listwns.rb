class Listwns < ClientData
	attr_accessible :username, :status
	virtual_attr_accessor :password
#	validates :password,
#            :presence => true
  def has_categories? 
    false
  end 


end
