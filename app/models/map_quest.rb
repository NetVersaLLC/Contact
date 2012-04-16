class MapQuest < ActiveRecord::Base
  serialize :secrets, CerebusClient.new
end
