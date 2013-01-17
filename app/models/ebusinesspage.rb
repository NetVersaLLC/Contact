class Ebusinesspage < ClientData
  attr_accessible :ebusinesspage_category_id, :ebusinesspage_category
belongs_to :ebusinesspage_category
end
