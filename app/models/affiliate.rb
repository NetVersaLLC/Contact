class Affiliate < ActiveRecord::Base
  attr_accessible :active, :code, :name
  has_many :subscriptions
end
