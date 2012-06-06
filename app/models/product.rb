class Product < ActiveRecord::Base
  attr_accessible :business_id, :name
  belongs_to :business
  validates :name,
            :presence => true
end
