class Primeplace < ClientData
	attr_accessible :username, :primeplace_category_id
	virtual_attr_accessor :password
belongs_to :primeplace_category

end
