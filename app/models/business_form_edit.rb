class BusinessFormEdit < ActiveRecord::Base 
  serialize :business_params, Hash
end 
