class Label < ActiveRecord::Base
  has_attached_file :logo, :styles => { :thumb => "100x100>" }
  attr_accessible :name, :domain, :custom_css, :login, :password, :logo
  has_many :users
  has_many :coupons
end
