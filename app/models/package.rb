class Package < ActiveRecord::Base
  attr_accessible :description, :name, :price, :short_description
  has_many :subscriptions

  def total
    if self.price == nil or self.price <= 0
      '$0.00'
    else
      "$%.02f" % (self.price / 100.0)
    end
  end
end
