class BackburnerProcess < ActiveRecord::Base
  attr_accessible :all_processes, :business_id, :processed, :user_id
end
