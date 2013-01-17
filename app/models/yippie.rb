class Yippie < ClientData
  attr_accessible :yippie_category_id, :yippie_category
  belongs_to :yippie_category
end
