class Payload < ActiveRecord::Base
  attr_accessible :data_generator, :name, :position, :status, :payload, :payload_category_id
  belongs_to :payload_category

  validates_uniqueness_of :name
  validates :name,
    :presence => true
  validates :position,
    :presence => true
  validates :payload,
    :presence => true
  validates :payload_category_id,
    :presence => true
end
