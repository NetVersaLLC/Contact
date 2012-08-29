class Hit < ActiveRecord::Base
  attr_accessible :assignment_id, :category_id, :remote_ip, :site, :tag_id, :user_agent
end
