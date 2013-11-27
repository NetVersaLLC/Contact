class WebImage < ActiveRecord::Base
  belongs_to :web_design 

  has_attached_file :data, :styles => { :gallery => "300x300>" } 

end 
