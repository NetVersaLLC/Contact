class Coupon < ActiveRecord::Base
  attr_accessible :code, :name, :login, :password, :percentage_off, :label_id 
  attr_accessible :redeemed_count, :allowed_upto

  belongs_to :label
  validates :percentage_off, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
  validates :allowed_upto, :numericality => { :greater_than => 0 }

  def self.get_for( something_for_a_label, code ) 
    Coupon.where( :label_id => something_for_a_label.label_id, 
                  :code => code )
  end 

  def self.get_available_for( something_for_a_label, code ) 
    Coupon.get_for(something_for_a_label, code)
          .where("redeemed_count < allowed_upto" )
  end 

  def self.redeem( something_for_a_label, code) 
    c = Coupon.get_for( something_for_a_label, code).first 

    c.update_attribute(:redeemed_count, c.redeemed_count + 1) if c 
  end 
end
