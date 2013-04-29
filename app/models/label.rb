class Label < ActiveRecord::Base
  has_attached_file :logo, :styles => { :thumb => "200x200>" }
  has_attached_file :favicon
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
    STDERR.puts "Got Gateway: #{@gateway.inspect}"
    @gateway
  end

  def favicon_url
    if self.favicon.exists?
      self.favicon.url
    else
      "/assets/favicon.ico"
    end
  end
end
