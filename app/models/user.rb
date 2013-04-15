class User < ActiveRecord::Base
  attr_accessor :temppass
  attr_accessible :callcenter

  validate :must_have_valid_access_level

  def must_have_valid_access_level
    unless TYPES.has_value? access_level
      errors.add(:access_level, "is not a valid access level")
    end
  end

  has_many   :businesses
  belongs_to :label

  after_create :deduct_credit
  def deduct_credit
    label = Label.find(self.label_id)
    label.credits = label.credits - 1
    label.save!
  end

  after_create :send_welcome
  def send_welcome
    UserMailer.welcome_email(self).deliver
  end

  TYPES = {
    :admin    => 46118,
    :reseller => 535311,
    :manager  => 1146463,
    :employee => 31161073,
    :owner    => 116390000
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token, :tos
  validates :tos, :acceptance => {:message=>"You must agree to the Terms of Service."}, :on=>:create

  before_save  :ensure_authentication_token

  def self.admin
    TYPES[:admin]
  end
  def self.reseller
    TYPES[:reseller]
  end
  def self.manager
    TYPES[:manager]
  end
  def self.employee
    TYPES[:employee]
  end
  def self.owner
    TYPES[:owner]
  end

  def admin?
    self.access_level == User.admin
  end
  def reseller?
    self.access_level <= User.reseller
  end
  def manager?
    self.access_level <= User.manager
  end
  def employee?
    self.access_level <= User.employee
  end
  def owner?
    self.access_level <= User.owner
  end

  def labels
    if self.admin?
      Label.where('id is not null')
    elsif self.reseller?
      Label.where(:id => self.label_id)
    end
  end

  def coupons
    if self.admin?
      Coupon.where('id is not null')
    elsif self.reseller?
      Coupon.where(:label_id => self.label_id)
    end
  end

  def packages
    if self.admin?
      Package.where('id is not null')
    elsif self.reseller?
      Package.where(:label_id => self.label_id)
    end
  end

  def business_scope
    if self.admin?
      Business.where('id is not null')
    elsif self.reseller?
      Business.where(:label_id => self.label_id)
    else
      Business.where(:user_id => self.id)
    end
  end

  def job_scope
    if self.reseller?
      Job.where('id is not null')
    else
      Job.where(:user_id => self.id)
    end
  end

  def user_scope
    if self.admin?
      User.where('id is not null')
    elsif self.reseller?
      User.where(:label_id => self.label_id)
    else
      User.where(:user_id => self.id)
    end
  end

end
