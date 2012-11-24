class Yellowbot < ActiveRecord::Base
  attr_accessible :business_id, :email, :force_update, :secrets
end
