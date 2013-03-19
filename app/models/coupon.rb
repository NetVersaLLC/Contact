class Coupon < ActiveRecord::Base
  attr_accessible :code, :name, :login, :password, :percentage_off, :label_id
  belongs_to :label
  validates :percentage_off, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
end
