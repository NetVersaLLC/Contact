class Ezlocal < ClientData
attr_accessible :email, :ezlocal_category_id, :ezlocal_category

	belongs_to :ezlocal_category

end
