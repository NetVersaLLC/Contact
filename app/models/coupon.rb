class Coupon < ActiveRecord::Base
  scope :label_match, -> { where(:label_id => current_user.label_id )}
  attr_accessible :code, :name, :login, :password, :label_id, :use_discount
  attr_accessible :percentage_off_monthly, :percentage_off_signup
  attr_accessible :dollars_off_monthly, :dollars_off_signup
  attr_accessible :redeemed_count, :allowed_upto

  belongs_to :label

  validates :use_discount, inclusion: { in: %w(percentage dollars)}
  validates :percentage_off_monthly, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  validates :percentage_off_signup, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  validates :dollars_off_monthly, :numericality => { :greater_than_or_equal_to => 0.0 } 
  validates :dollars_off_signup, :numericality => { :greater_than_or_equal_to => 0.0 } 

  validates :allowed_upto, :numericality => { :greater_than => 0 }


  def self.get_for( label, code ) 
    Coupon.where( :label_id => label.id, 
                  :code => code )
  end 

  def self.get_available_for( label, code ) 
    Coupon.get_for(label, code)
          .where("redeemed_count < allowed_upto" )
  end 

  def self.redeem( label, code) 
    c = Coupon.get_for( label, code).first 

    c.update_attribute(:redeemed_count, c.redeemed_count + 1) if c 
  end 
end
