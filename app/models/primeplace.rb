class Primeplace < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	validates :password,
            :presence => true


end
