class Subscription < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessor   :card_number, :card_type, :exp_year, :exp_month, :cvv, :coupon_code
  attr_accessible :card_number, :card_type, :exp_year, :exp_month, :cvv, :coupon_code
  attr_accessible :address, :address2, :affiliate_id, :city, :first_name, :last_name, :package_id, :package_name, :phone, :state, :tos_agreed, :total, :zip
  has_one :business
  belongs_to :package

  validates :total,
    :presence => true,
    :numericality => true
  validates :package_id, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :address, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true

  validates :card_type,   :presence => true
  validates :card_number, :presence => true
  validates :exp_year,    :presence => true
  validates :exp_month,   :presence => true
  validates :cvv,         :presence => true

  validates :coupon_code,
    :allow_blank => true,
    :format => {:with => /^[A-Z0-9]{10}$/}

  def self.years
    (Time.now.year .. Time.now.year + 10).to_a
  end

  def self.months
    months = {}
    Date::MONTHNAMES[1..12].each_with_index do |e,i|
      months[e] = (i + 1).to_s
    end
    months
  end

  def self.cards
    %w/visa mastercard/
  end
end
