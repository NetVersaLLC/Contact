class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token

  before_save :ensure_authentication_token
  after_create :create_business, :copy_rookies

  def create_business
    Business.create do |b|
      b.user_id = self.id
      b.email   = self.email
    end
  end
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

  has_many :jobs, :order => "position"
end
