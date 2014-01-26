class User < ActiveRecord::Base
  attr_accessor :temp_password

  attr_accessible :avatar, :username, :password_confirmation, :first_name, :middle_name, :last_name,  as: [:default, :admin]
  attr_accessible :mobile_phone, :mobile_appears, :prefix, :callcenter, :date_of_birth,               as: [:default, :admin]
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token,     as: [:default, :admin]
  attr_accessible :tos, :referrer_code, :gender, :reseller_id, :manager_id, :cost_center_id,          as: [:default, :admin]
  attr_accessible :access_level, :label_id,                                                           :as => :admin

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => "36x36" }, :default_url => "/assets/user_blue.png" # "/images/:style/missing_user.png"

  #validate :must_have_valid_access_level
  validates :email, :presence => true
  #validates :password, :presence => true
  #validates :password_confirmation, :presence => true
  #validates :tos, :acceptance => {:message => "You must agree to the Terms of Service."}, :on => :create

  
  def must_have_valid_access_level
    unless TYPES.has_value? access_level
      errors.add(:access_level, "is not a valid access level")
    end
  end

  has_many   :businesses #, dependent: :destroy
  belongs_to :label

  def self.send_welcome(user)
    UserMailer.welcome_email(user).deliver
  end

  def display_name # used by activeadmin drop down 
    self.email
  end
  def full_name 
    "#{first_name} #{last_name}" 
  end

  ROLES =  ["Customer Service Agent","Sales Person", "Manager", "Reseller", "Administrator"]
  TYPES = {
      :admin => 46118,
      :reseller => 535311,
      :manager => 1146463,
      :employee => 31161073,
      :owner => 116390000
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable #, :token_authenticatable

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


  def role_is
    self.class.name.humanize #User::TYPES.key(self.access_level).try(:to_s).try(:humanize)
  end

  def labels
    nil
  end

  def coupons
    nil
  end

  def packages
    nil
  end

  def business_scope
    self.busineses
  end

  def job_scope
    Job.where(:user_id => self.id)
  end

  def user_scope
    User.where(:user_id => self.id)
  end

  
  def ensure_authentication_token
    if authentication_token.blank? 
      self.authentication_token = generate_authentication_token 
    end 
  end 

  def operating_system 
    UserAgent.parse(self.last_user_agent).os
  end 

  def browser
    if self.last_user_agent.present?
      ua = UserAgent.parse(self.last_user_agent)
      "#{ua.browser} #{ua.version}"
    end 
  end 

  private

  def generate_authentication_token
    loop do 
      token = Devise.friendly_token 
      break token unless User.where(authentication_token: token).first
    end 
  end 



end
