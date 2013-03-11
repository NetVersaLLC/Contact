class Package < ActiveRecord::Base
  attr_accessible :description, :name, :price, :short_description, :monthly_fee
  has_many :package_payloads
  has_many :subscriptions
  belongs_to :labels

  validates :monthly_fee,
    :numericality => { :greater_than => 0 }
  validates :price,
    :numericality => { :greater_than => 0 }
  validates :label_id,
    :presence => true

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

  def self.apply_coupon(package_id, coupon)
    package = Package.find(package_id)
    if coupon
      package.price       = package.price       * ( 1.0 - (100 / coupon.percentage_off) )
      package.monthly_fee = package.monthly_fee * ( 1.0 - (100 / coupon.percentage_off) )
    end
    package
  end
end
