class Coupon < ActiveRecord::Base
  attr_accessible :code, :name, :login, :password, :percentage_off, :label_id
  belongs_to :label

  def get_gateway
    gateway = ActiveMerchant::Billing::Base.gateway(:authorize_net).new(
      :login    => self.login,
      :password => self.password,
      :test     => true
    )
    gateway
  end
end
