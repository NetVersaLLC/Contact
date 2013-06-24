class Code < ActiveRecord::Base 
  attr_accessible :code, :site_name 
  
  belongs_to :business
end 
