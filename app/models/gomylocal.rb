class Gomylocal < ClientData
	attr_accessible :username, :secret1
	virtual_attr_accessor :password
	validates :password,
            :presence => true
end
