class SiteProfile < ActiveRecord::Base
  attr_accessible :alexa_us_traffic_rank, :founded, :notes, :owner, :page_rank, :site, :traffic_stats, :url
end
