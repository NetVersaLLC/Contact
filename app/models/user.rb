class User < ActiveRecord::Base
  validate :must_have_valid_access_level

  def must_have_valid_access_level
    unless TYPES.has_value? access_level
      errors.add(:access_level, "is not a valid access level")
    end
  end

  has_many :jobs, :order => "position"
  belongs_to :business

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

  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token

  before_save  :ensure_authentication_token
  after_create :copy_rookies

  def copy_rookies
    Rookie.order(:position).each do |rookie|
      Job.create(
        :user_id => self.id,
        :payload => rookie.payload,
        :name    => rookie.name,
        :status  => 'new'
      )
    end
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

end
