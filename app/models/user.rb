class User < ActiveRecord::Base
  attr_accessor :temppass
  attr_accessible :callcenter
  attr_accessible :access_level, :as => :admin
  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => "36x36" }, :default_url => "/assets/user_blue.png" # "/images/:style/missing_user.png"

  validate :must_have_valid_access_level
  
  def must_have_valid_access_level
    unless TYPES.has_value? access_level
      errors.add(:access_level, "is not a valid access level")
    end
  end

  has_one :download
  has_many :businesses
  belongs_to :label

  scope :needs_to_download_client, where(:downloads => {:id => nil}).includes(:download)

  #callbacks
  before_destroy :delete_all_associated_records

#  after_create :send_welcome

  def self.send_welcome(user)
    UserMailer.welcome_email(user).deliver
  end

  def display_name # used by activeadmin drop down 
    self.email
  end

  TYPES = {
      :admin => 46118,
      :reseller => 535311,
      :manager => 1146463,
      :employee => 31161073,
      :owner => 116390000
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token, :tos, :referrer_code
  validates :email, :presence => true
  validates :password, :presence => true
  validates :password_confirmation, :presence => true
  validates :tos, :acceptance => {:message => "You must agree to the Terms of Service."}, :on => :create

  before_save :ensure_authentication_token

  def self.send_reset_password_instructions(attributes={})
    s = super(attributes)
    if s.errors.any?
      s.errors.add(:email, "not found") unless s.valid?
    end
    s
  end

  def to_s 
    email 
  end 

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

  def role_is
    User::TYPES.key(self.access_level).try(:to_s).try(:humanize)
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
      Business.where('businesses.id is not null')
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

  private

  def delete_all_associated_records
    self.download.destroy unless self.download.blank?
    businesses_records = self.businesses
    businesses_records.each do |business|
      business.destroy
    end unless businesses_records.blank?
  end

end
