class Localcom < ActiveRecord::Base
  attr_accessible :business_id, :force_update, :secrets, :username
end
