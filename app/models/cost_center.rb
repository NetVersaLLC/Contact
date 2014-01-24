class CostCenter < ActiveRecord::Base 

  attr_accessible :name, :label_id

  belongs_to :label

  has_many :managers
  has_many :customer_service_agents

end 
