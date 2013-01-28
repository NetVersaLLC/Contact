class Digabusiness < ClientData
  attr_accessible :digabusiness_category_id
  belongs_to            :digabusiness_category
end
