class Business < ActiveRecord::Base

  attr_accessible :yelp_category_id
  add_nested :yelps, :map_quests, :twitters, :facebooks

  def make_contact
    [first_name, middle_name, last_name].join(" ").gsub(/\s+/, ' ')
  end

  has_many :jobs, :order => "position"
  belongs_to :user
  has_attached_file :logo, :styles => { :thumb => "100x100>" }

  attr_accessible :mail_host, :mail_port, :mail_username, :mail_password
  attr_accessible :business_name, :corporate_name, :duns_number, :sic_code, :contact_gender, :contact_prefix, :contact_first_name, :contact_middle_name, :contact_last_name, :company_email, :local_phone, :alternate_phone, :toll_free_phone, :mobile_phone, :mobile_appears, :fax_number, :address, :address2, :city, :state, :zip
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

  attr_accessible :twitters_attributes
  has_many :twitters, :dependent => :destroy
  accepts_nested_attributes_for :twitters, :allow_destroy => true

  attr_accessible :facebooks_attributes
  has_many :facebooks, :dependent => :destroy
  accepts_nested_attributes_for :facebooks, :allow_destroy => true

  attr_accessible :yelps_attributes
  has_many :yelps, :dependent => :destroy
  accepts_nested_attributes_for :yelps, :allow_destroy => true

  attr_accessible :foursquares_attributes
  has_many :foursquares, :dependent => :destroy
  accepts_nested_attributes_for :foursquares, :allow_destroy => true

  attr_accessible :map_quests_attributes
  has_many :map_quests, :dependent => :destroy
  accepts_nested_attributes_for :map_quests, :allow_destroy => true

  def self.email_regex
    /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  end

  def self.phone_regex
    /^\d\d\d-\d\d\d-\d\d\d\d$/
  end

  validates :business_name,
    :presence => true
  validates :company_email,
    :presence => true,
    :format => { :with => email_regex }
  validates :local_phone,
    :presence => true,
    :format => { :with => phone_regex }
  validates :alternate_phone,
    :allow_blank => true,
    :format => { :with => phone_regex }
  validates :toll_free_phone,
    :allow_blank => true,
    :format => { :with => /^8\d\d-\d\d\d-\d\d\d\d$/ }
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
    :allow_blank => true,
    :format => { :with => /^\d\d\d\d$/ }
  validates :company_website,
    :presence => true,
    :format => { :with => /^https?\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?$/ }
  validates :fan_page_url,
    :allow_blank => true,
    :format => { :with => /^https?\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?$/ }

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
  def self.site_accounts
    [
      ['Twitter', 'twitters',
        [
          ['text', 'username'],
          ['text', 'password']
        ]
      ],
      ['Facebook', 'facebooks',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['Yelp', 'yelps',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['foursquare', 'foursquares',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['Mapquest', 'map_quests',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ]
    ]
  end

  def self.bullshit_accounts
    [
      ['Twitter', 'twitters',
        [
          ['text', 'username'],
          ['text', 'password']
        ]
      ],
      ['Facebook', 'facebooks',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['Yelp', 'yelps',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['foursquare', 'foursquares',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['Mapquest', 'map_quests',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['CitySearch', 'city_search',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['Ezlocal', 'ezlocal',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['MerchantCircle', 'merchant_circle',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['CityGrid', 'city_grid',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['GooglePlusLocal', 'google_plus_local',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['Kudzu', 'kudzu',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['Yahoo Local', 'yahoo_local',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ],
      ['Yellowbot', 'yellowbot',
        [
          ['text', 'email'],
          ['text', 'password']
        ]
      ]
    ]
  end
  def nonexistent_accounts
    list = []
    Business.site_accounts.each do |site|
      list.push site if self.send(site[1]).count == 0
    end
    list
  end
  def accounts
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
end
