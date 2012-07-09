class PayloadCategory < ActiveRecord::Base
  attr_accessible :name, :position
  has_many :payloads
end
