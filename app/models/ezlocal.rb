class Ezlocal < ClientData
attr_accessible :email, :ezlocal_category_id

	belongs_to :ezlocal_category

end
