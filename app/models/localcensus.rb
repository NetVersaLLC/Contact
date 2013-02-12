class Localcensus < ClientData
  attr_accessible :localcensus_category_id
  belongs_to :localcensus_category
end
