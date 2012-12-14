class Business < ActiveRecord::Base
  include Business::SiteAccounts

  has_attached_file :logo, :styles => { :thumb => "100x100>" }
  after_create      :create_site_accounts
  after_create      :create_jobs
  has_many          :jobs, :order => "position"
  belongs_to        :user
  belongs_to        :subscription
  has_many          :notifications

  attr_accessible :business_name, :corporate_name, :duns_number, :sic_code
  attr_accessible :contact_gender, :contact_prefix, :contact_first_name, :contact_middle_name, :contact_last_name, :contact_birthday
  attr_accessible :local_phone, :alternate_phone, :toll_free_phone, :mobile_phone, :mobile_appears, :fax_number
  attr_accessible :address, :address2, :city, :state, :zip
  attr_accessible :open_24_hours, :open_by_appointment
  attr_accessible :monday_enabled, :tuesday_enabled, :wednesday_enabled, :thursday_enabled, :friday_enabled, :saturday_enabled, :sunday_enabled
  attr_accessible :monday_open, :monday_close, :tuesday_open, :tuesday_close, :wednesday_open, :wednesday_close, :thursday_open, :thursday_close, :friday_open, :friday_close, :saturday_open, :saturday_close, :sunday_open, :sunday_close
  attr_accessible :accepts_cash, :accepts_checks, :accepts_mastercard, :accepts_visa, :accepts_discover, :accepts_diners, :accepts_amex, :accepts_paypal, :accepts_bitcoin
  attr_accessible :business_description, :services_offered, :specialies, :professional_associations, :languages, :geographic_areas, :year_founded
  attr_accessible :company_website, :incentive_offers, :links_to_photos, :links_to_videos
  attr_accessible :category1, :category2, :category3
  attr_accessible :other_social_links, :positive_review_links
  attr_accessible :keyword1, :keyword2, :keyword3, :keyword4, :keyword5
  attr_accessible :competitors, :most_like, :industry_leaders
  attr_accessible :fan_page_url
  attr_accessible :logo

  add_nested :accounts
  add_nested :twitters
  add_nested :facebooks
  add_nested :yelps
  add_nested :yahoos
  add_nested :bings
  add_nested :googles
  add_nested :map_quests
  add_nested :foursquares
  add_nested :angies_lists
  add_nested :businesscoms
  add_nested :aols
  add_nested :citisquares
  add_nested :getfavs
  add_nested :merchantcircles
  add_nested :kudzus
  add_nested :mojopages
  add_nested :mantas
  add_nested :yellow_bots
  add_nested :localdatabases
  add_nested :tupalos

  # This classify()s "crunchases" to Crunchbasis
  # so we need to manaully set "class_name"
  # add_nested      :crunchbases
  has_many :crunchbases, :dependent => :destroy, :class_name => "Crunchbase"
  attr_accessible :crunchbases_attributes
  accepts_nested_attributes_for :crunchbases, :allow_destroy => true

  def self.phone_regex
    /^\d\d\d-\d\d\d-\d\d\d\d$/
  end

  validates :category1,
    :presence => true
  validates :category2,
    :presence => true
  validates :category3,
    :presence => true
  validates :business_name,
    :presence => true
  validates :contact_gender,
    :presence => true
  validates :contact_first_name,
    :presence => true
  validates :contact_last_name,
    :presence => true
  validates :local_phone,
    :presence => true,
    :format => { :with => phone_regex }
  validates :alternate_phone,
    :allow_blank => true,
    :format => { :with => phone_regex }
  validates :toll_free_phone,
    :allow_blank => true,
    :format => { :with => /^(?:888|877|866|855|844|833|822|800)-\d\d\d-\d\d\d\d$/ }
  validates :mobile_phone,
    :allow_blank => true,
    :format => { :with => phone_regex }
  validates :fax_number,
    :allow_blank => true,
    :format => { :with => phone_regex }
  validates :address,
    :presence => true
  validates :business_description,
    :presence => true
  validates :geographic_areas,
    :presence => true
  validates :year_founded,
    :presence => true
  validates :fan_page_url,
    :allow_blank => true,
    :format => { :with => /^https?\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?$/ }
  validates :contact_birthday,
    :presence => true,
    :format => { :with => /^\d\d\/\d\d\/\d\d\d\d$/ }

  after_initialize :set_times
  def set_times
    ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'].each do |day|
      self.send "#{day}_open=", '08:30AM' if self.send("#{day}_open") == nil
      self.send "#{day}_close=", '05:30PM'  if self.send("#{day}_close") == nil
    end
  end
  def self.list_times
    list = []
    a = Time.new(0)
    48.times do |k|
      list.push (a += 1800).strftime("%I:%M%p")
    end
    list.unshift list.pop
    list
  end
  def payment_methods
    ['cash', 'checks', 'mastercard', 'visa', 'discover', 'diners', 'amex', 'paypal', 'bitcoin']
  end
  def self.gender_list
    ['Male', 'Female', 'Unknown']
  end
  def self.prefix_list
    ['Mr.', 'Mrs.', 'Miss.', 'Ms.', 'Dr.', 'Prof.']
  end
  def name
    [self.contact_first_name, self.contact_middle_name, self.contact_last_name].join(" ").gsub(/\s+/, ' ')
  end
  def state_name
    states = {"AL"=>"Alabama", "AK"=>"Alaska", "AZ"=>"Arizona", "AR"=>"Arkansas", "CA"=>"California", "CO"=>"Colorado", "CT"=>"Connecticut", "DE"=>"Delaware", "FL"=>"Florida", "GA"=>"Georgia", "HI"=>"Hawaii", "ID"=>"Idaho", "IL"=>"Illinois", "IN"=>"Indiana", "IA"=>"Iowa", "KS"=>"Kansas", "KY"=>"Kentucky", "LA"=>"Louisiana", "ME"=>"Maine", "MD"=>"Maryland", "MA"=>"Massachusetts", "MI"=>"Michigan", "MN"=>"Minnesota", "MS"=>"Mississippi", "MO"=>"Missouri", "MT"=>"Montana", "NE"=>"Nebraska", "NV"=>"Nevada", "NH"=>"New Hampshire", "NJ"=>"New Jersey", "NM"=>"New Mexico", "NY"=>"New York", "NC"=>"North Carolina", "ND"=>"North Dakota", "OH"=>"Ohio", "OK"=>"Oklahoma", "OR"=>"Oregon", "PA"=>"Pennsylvania", "RI"=>"Rhode Island", "SC"=>"South Carolina", "SD"=>"South Dakota", "TN"=>"Tennessee", "TX"=>"Texas", "UT"=>"Utah", "VT"=>"Vermont", "VA"=>"Virginia", "WA"=>"Washington", "WV"=>"West Virginia", "WI"=>"Wisconsin", "WY"=>"Wyoming"}
    unless states[ self.state ].nil?
      states[ self.state ]
    else
      nil
    end
  end

  def self.geographic_areas_list
    list = ['Worldwide', 'Unknown']
    number = 10
    1.upto(9) do
      list.push "Within #{number} Miles"
      number += 10
    end
    1.upto(9) do
      list.push "Within #{number} Miles"
      number += 100
    end
    list
  end

  def self.site_accounts_by_key
    hash = {}
    self.site_accounts.each do |site|
      hash[ site[1] ] = site
    end
    hash
  end

  def nonexistent_accounts
    list = []
    Business.site_accounts.each do |site|
      list.push site if self.send(site[1]).count == 0
    end
    list
  end
  def nonexistent_accounts_array
    @accounts = []
    self.nonexistent_accounts.each do |site|
      @accounts.push site[0 .. 1]
    end
    @accounts
  end
  def sites
    list = []
    Business.site_accounts.each do |site|
      list.push site if self.send(site[1]).count > 0
    end
    list
  end
  def checkin
    self.client_checkin = Time.now
    save
  end
  def birthday
    Date.strptime(self.contact_birthday, '%m/%d/%Y')
  end
  def self.sub_models
    [AngiesList, Aol, Businesscom, Citisquare, Getfav, Yahoo, Bing, Google, Merchantcircle, Manta, Kudzu, Mojopage, YellowBot, Localdatabase, Crunchbase, Tupalo]
  end
  def create_site_accounts
    Business.sub_models.each do |klass| 
      y = klass.new
      y.business_id = self.id
      y.password = ''
      y.save
    end
  end
  def self.get_sub_model(str)
    Business.sub_models.each do |klass|
      STDERR.puts "Comparing #{str} <=> #{klass.class.to_s}"
      if klass.to_s == str
        return klass
      end
    end
    nil
  end
  def create_jobs
    sub = nil
    # NOTE: this is probably a bug, leaving it since most accounts
    # will not have subscriptions initially
    if self.subscription_id == nil
      sub = Subscription.create do |sub|
        sub.package_id   = Package.first
        sub.package_name = Package.first.name
        sub.total        = Package.first.price
        sub.tos_agreed   = true
        sub.active       = true
      end
    else
      sub = self.subscription
    end
    PackagesPayloads.where(:package_id => sub.package_id).each do |obj|
      payload  = Payload.new( obj.site, obj.payload )
      job      = Job.inject(self.id, payload.payload, payload.data_generator, payload.ready)
      job.name = "#{obj.site}/#{obj.payload}"
      job.save
    end
  end
  def get_label
    self.user.label
  end
end
