class Gomylocal < ClientData
	attr_accessible :username
	virtual_attr_accessor :password
	belongs_to :gomylocal_category
end
