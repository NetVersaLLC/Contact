class BusinessSiteMode < ActiveRecord::Base
  belongs_to :business
  belongs_to :site
  belongs_to :mode
end