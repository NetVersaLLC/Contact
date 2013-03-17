class Package < ActiveRecord::Base
  attr_accessor :original_price, :saved
  attr_accessible :original_price, :saved
  attr_accessible :description, :name, :price, :short_description, :monthly_fee
  has_many :package_payloads
  has_many :subscriptions
  belongs_to :labels

  validates :monthly_fee,
    :numericality => { :greater_than => 0 },
    :presence => true
  validates :price,
    :numericality => { :greater_than => 0 },
    :presence => true
  validates :label_id,
    :presence => true

  def self.list
    ret = []
    Package.all.each do |package|
      ret.push package.name
    end
    ret
  end

  def apply_coupon(coupon)
    self.original_price = price
    if coupon
      price   = (price * (1.0 - (coupon.percentage_off / 100.0))).to_i
      # NOTE: If coupon is 100% off then no subscription cost.
      if coupon.percentage_off == 100
        self.monthly_fee = 0
      end
      self.saved = self.original_price - price
    else
      self.saved = 0
      self.original_price = price
    end
  end
end
