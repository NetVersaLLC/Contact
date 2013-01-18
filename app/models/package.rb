class Package < ActiveRecord::Base
  attr_accessible :description, :name, :price, :short_description, :monthly_fee
  has_many :subscriptions

  def self.list
    ret = []
    Package.all.each do |package|
      ret.push package.name
    end
    ret
  end
  def show_initial_fee
    if self.price == nil or self.price <= 0
      '$0.00'
    else
      "$%.02f" % (self.price / 100.0)
    end
  end
  def show_monthly_fee
    if self.monthly_fee == nil or self.monthly_fee <= 0
      '$0.00'
    else
      "$%.02f" % (self.monthly_fee / 100.0)
    end
  end
end
