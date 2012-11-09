class Package < ActiveRecord::Base
  attr_accessible :description, :name, :price, :short_description
  has_many :subscriptions

  def self.list
    ret = []
    Package.all.each do |package|
      ret.push package.name
    end
    ret
  end
  def total
    if self.price == nil or self.price <= 0
      '$0.00'
    else
      "$%.02f" % (self.price / 100.0)
    end
  end
end
