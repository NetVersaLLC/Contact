class Payload < ActiveRecord::Base
  attr_accessible :model, :name, :location, :status, :payload
end
