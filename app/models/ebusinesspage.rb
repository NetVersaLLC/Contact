class Ebusinesspage < ClientData
	attr_accessible :ebusinesspage_category_id, :ebusinesspage_category, :username
	virtual_attr_accessor :password
	belongs_to :ebusinesspage_category

end
