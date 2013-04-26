class Label < ActiveRecord::Base
  has_attached_file :logo, :styles => { :thumb => "200x200>" }
  attr_accessible :name, :domain, :custom_css, :login, :password, :logo, :footer
  attr_accessible :mail_from

  acts_as_tree :order => :name
  has_many :users
  has_many :coupons
  has_many :packages
  has_many :credit_events 

  def display_name # activeadmin 
    name 
  end 

  validates :login,
    :presence => true,
    :format => { :with => /\S*/ }
  validates :password,
    :presence => true,
    :format => { :with => /\S*/ }
  validates :domain,
    :presence => true
  validates :logo,
    :presence => true

  def gateway
    ActiveMerchant::Billing::Base.mode = :test
    return @gateway if @gateway
    @gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
      # iwntbbnprn2
      #
      :login    => "8e3UfTHKM9d2",
      :password => "5B7t5V6S65m3WkdU",
      :test     => true
    )
    if Rails.env.to_sym == :production
      @gateway = ActiveMerchant::Billing::Base.gateway(:authorize_net).new(
        :login    => self.login,
        :password => self.password,
      )
      ActiveMerchant::Billing::Base.mode = :production
    end
    @gateway
  end

  # transfer credits to a child 
  def transfer_to( to, quantity, by ) 
    quantity = quantity.to_i

    Label.transaction do 
      to.reload(:lock => true) 
      self.reload(:lock => true) 

      raise ActiveRecord::Rollback, "Insufficient credits"  if self.credits < quantity

      self.credits -= quantity 
      to.credits += quantity 
      save! 
      to.save!

      ce = CreditEvent.new( {quantity: -quantity, action: :transfer_to} ) 
      ce.label = self; 
      ce.other = to
      ce.user = by
      ce.save 
      
      ce = CreditEvent.new( {quantity: +quantity, action: :transfer_from} )
      ce.label = to
      ce.other = self
      ce.user =  by 
      ce.save 
    end 
  end 

end
