class Label < ActiveRecord::Base
  has_attached_file :logo, :styles => { :thumb => "200x200>" }
  attr_accessible :name, :domain, :custom_css, :login, :password, :logo, :footer,:is_pdf ,:is_show_password
  has_attached_file :favicon
  attr_accessible :name, :domain, :custom_css, :login, :password, :logo, :footer,:is_pdf ,:is_show_password, :favicon
  attr_accessible :mail_from, :theme

  acts_as_tree :order => :name
  has_many :users
  has_many :coupons
  has_many :packages
  has_many :credit_events 

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

  validates_format_of :favicon_file_name,
    :allow_blank => true,
    :with => /.ico$/i

  def gateway
    return @gateway if @gateway
    if Rails.env.to_sym == :production
      @gateway = ActiveMerchant::Billing::Base.gateway(:authorize_net).new(
        :login    => self.login,
        :password => self.password,
      )
      ActiveMerchant::Billing::Base.mode = :production
    else
      @gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
        :login    => "8e3UfTHKM9d2",
        :password => "5B7t5V6S65m3WkdU",
        :test     => true
      )
      ActiveMerchant::Billing::Base.mode = :test
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
