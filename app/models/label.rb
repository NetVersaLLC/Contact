class Label < ActiveRecord::Base
  has_attached_file :logo, :styles => { :thumb => "200x200>" }
  attr_accessible :name, :domain, :custom_css, :login, :password, :logo, :footer
  has_many :users
  has_many :coupons
  has_many :packages

  def get_gateway
    gateway = ActiveMerchant::Billing::Base.gateway(:authorize_net).new(
      :login    => self.login,
      :password => self.password,
    )
    gateway
  end
end
