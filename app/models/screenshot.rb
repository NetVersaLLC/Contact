class Screenshot < ActiveRecord::Base
  attr_accessible :data
  has_attached_file :data, :styles => { :medium => "300x300>" }, :default_url => "/assets/missing.png"
end
