class Coupon < ActiveRecord::Base
  attr_accessible :code, :name, :login, :password, :percentage_off, :label_id
  belongs_to :label

end
