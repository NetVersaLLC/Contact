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

  def self.apply_coupon(package, coupon)
    old_price = package.price
    if coupon
      package.price       = (package.price * (1.0 - (coupon.percentage_off / 100.0))).to_i
      if coupon.percentage_off == 100
        package.monthly_fee = 0
      end
    end
    old_price - package.price
  end
end
