class Payload < ActiveRecord::Base
  attr_accessible :data_generator, :name, :position, :status, :payload, :payload_category_id
  belongs_to :payload_category
end
