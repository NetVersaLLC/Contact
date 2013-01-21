class Label < ActiveRecord::Base
  has_attached_file :logo, :styles => { :thumb => "100x100>" }
  attr_accessible :name, :domain, :admin_user_id, :custom_css, :logo_content_type, :logo_file_name, :logo_file_size, :logo_updated_at
  has_many :admin_users
  has_many :coupons
end
