class Code < ActiveRecord::Base 
  attr_accessible :code, :site_name, :next_job 
  
  belongs_to :business
end 
