class YahooCategory < ActiveRecord::Base
  attr_accessible :subcatname, :catname
  belongs_to      :google_category
end
