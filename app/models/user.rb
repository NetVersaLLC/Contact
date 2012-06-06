class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token

  before_save :ensure_authentication_token
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

  has_many :jobs, :order => "position"
  belongs_to :business
end
