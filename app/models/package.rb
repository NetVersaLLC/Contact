class Package < ActiveRecord::Base
  include ApplicationHelper
  attr_accessor :original_price, :saved
  attr_accessible :original_price, :saved
  attr_accessible :description, :name, :price, :short_description, :monthly_fee #, :label_id
  has_many :package_payloads
  has_many :subscriptions
  #belongs_to :label

  validates :monthly_fee,
    :numericality => { :greater_than => 0 },
    :presence => true
  validates :price,
    :numericality => { :greater_than => 0 },
    :presence => true
  #validates :label_id,  :presence => true

  def subtotal
    original_price.presence || self.price 
  end 
  def saved 
    subtotal - self.price 
  end 

  def available_jobs
    package_payloads.map{ |p| p.site.payloads.map{ |pl| p.site.name + '/' + pl.name}}.flatten
  end 

  def self.list
    ret = []
    Package.all.each do |package|
      ret.push package.name
    end
    ret
  end

  def apply_coupon(coupon)
    self.original_price = self.price
    if coupon
      if coupon.use_discount == "percentage" 
        self.price   = (self.price * (1.0 - (coupon.percentage_off_signup / 100.0))).to_i
        self.monthly_fee = (self.monthly_fee * (1.0 - (coupon.percentage_off_monthly / 100.0))).to_i
      elsif coupon.use_discount == "dollars"
        self.price       -= coupon.dollars_off_signup  > self.price ? self.price : coupon.dollars_off_signup
        self.monthly_fee -= coupon.dollars_off_monthly > self.monthly_fee ? self.monthly_fee : coupon.dollars_off_monthly
      end 
      self.saved = self.original_price - self.price
    else
      self.saved = 0
      self.original_price = self.price
    end
  end
end
