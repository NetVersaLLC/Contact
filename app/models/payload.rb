class Payload < ActiveRecord::Base
  attr_accessible :model, :name, :location, :status, :payload, :payload_category_id
  belongs_to :payload_category
end
