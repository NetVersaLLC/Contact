class WebDesign < ActiveRecord::Base
  has_many :web_images

  attr_accessible :page_name, :body, :web_images_attributes, :business_id
  accepts_nested_attributes_for :web_images, allow_destroy: true
end 
