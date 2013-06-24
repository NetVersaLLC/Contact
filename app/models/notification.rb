class Notification < ActiveRecord::Base
  attr_accessible :body, :business_id, :title, :url
  belongs_to :business
end
