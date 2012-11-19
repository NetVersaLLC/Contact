class Notification < ActiveRecord::Base
  attr_accessible :body, :business_id, :title, :url
end
