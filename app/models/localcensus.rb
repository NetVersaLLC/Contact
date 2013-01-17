class Localcensus < ClientData
  attr_accessible :localcensus_category_id, :localcensus_category
  belongs_to :localcensus_category
end
