class Label < ActiveRecord::Base
  has_attached_file :logo, :styles => { :thumb => "200x200>" }
  has_attached_file :favicon, :styles => { :thumb => "200x200>" }
  attr_accessible :name, :domain, :custom_css, :login, :password, :logo, :footer,:is_pdf ,:is_show_password, :favicon
  attr_accessible :mail_from, :theme, :credit_limit, :package_signup_rate, :package_subscription_rate

  acts_as_tree :order => :name
  has_many :users
  has_many :coupons
  #has_many :packages
  #has_many :package_payloads
  has_many :credit_events 
  has_many :transaction_events

  THEMES = %w{ ace amelia cerulean cosmo cyborg journal readable simplex slate spacelab spruce superhero united }
  
  def css_is_set?
    theme != nil && !theme.empty?
  end

  def theme_css_files
    themes = case theme
    when 'ace'
      ['ace','ace-responsive','ace-skins'].map {|x| "<link rel='stylesheet' href='#{THEME_PATH}/ace/css/#{x}.min.css' />" }.join.html_safe
    else
      "<link rel='stylesheet' href='#{THEME_PATH}/#{theme}.min.css' />".html_safe
    end
  end

  def theme_js_files
    themes = case theme
    when 'ace'
      ['ace','ace-elements'].map {|x| "<script src='#{THEME_PATH}/ace/js/#{x}.min.js'></script>" }.join.html_safe
    end
  end

  def display_name # activeadmin 
    name 
  end 

  def credit_held_by_children 
    children.sum(:credit_limit)
  end
  def funds_available
    credit_limit + available_balance - credit_held_by_children
  end 

  validates :login,
    #:presence => true,             # resellers cant create a label if validating presence
    :format => { :with => /\S*/ }
  validates :password,
    #:presence => true,
    :format => { :with => /\S*/ }
  validates :domain,
    :presence => true
  validates :logo,
    :presence => true
  validates_format_of :favicon_file_name,
    :allow_blank => true,
    :with => %r{\.(ico|jpg|jpeg|png)$}i
  validate :credit_limit_within_range

  def credit_limit_within_range
    # cant be more than what the parent has available 
    unless self.parent.nil? 
      was = self.credit_limit_was
      if self.credit_limit > self.parent.credit_limit - parent.credit_held_by_children + was
        errors.add(:credit_limit, "The parent label does not have enough credit available.") 
      end 
    end

    # need enough to cover the children 
    if self.credit_limit < self.credit_held_by_children 
      errors.add(:credit_limit, "There needs to be enough credit to cover the amount held by the sub labels.")
    end
  end 


#  def gateway
#    return @gateway if @gateway
#    if Rails.env.to_sym == :production
#      @gateway = ActiveMerchant::Billing::Base.gateway(:authorize_net).new(
#        :login    => self.login,
#        :password => self.password,
#      )
#      ActiveMerchant::Billing::Base.mode = :production
#    else
#      @gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
#        :login    => "8e3UfTHKM9d2",
#        :password => "5B7t5V6S65m3WkdU",
#        :test     => true
#      )
#      ActiveMerchant::Billing::Base.mode = :test
#    end
#    STDERR.puts "Got Gateway: #{@gateway.inspect}"
#    @gateway
#  end

  def favicon_url
    if self.favicon.exists?
      self.favicon.url
    else
      "/assets/favicon.ico"
    end
  end
end
