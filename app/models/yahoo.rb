class Yahoo < ActiveRecord::Base
  attr_accessible       :email, :yahoo_category_id
  virtual_attr_accessor :password, :secret1, :secret2
  belongs_to            :yahoo_category

  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
            :presence => true
  validates :secret1,
            :presence => true
  validates :secret2,
            :presence => true

  def make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end
  def make_secret_answer1
    Faker::Name.first_name
  end
  def make_secret_answer2
    Faker::Address.city
  end
  def payment_methods(business)
    methods = {}
    [
      ["cash",      'Cash Only'],
      ["checks",    'Personal Checks'],
      ["visa",      'Visa'],
      ["mastercard",'Mastercard'],
      ["amex",      'American Express'],
      ["discover",  'Discover'],
      ["diners",    'Diners Club']
    ].each do |row|
      methods[row[0]] = row[1]
    end
    accepted = []
    methods.each_key do |type|
      if business.send("accepts_#{type}".to_sym) == true
        accepted.push methods[type]
      end
    end
    accepted
  end

  def self.get_signup_data(business)
    data = {}
    data[ 'first_name' ]        = business.contact_first_name
    data[ 'last_name' ]         = business.contact_last_name
    data[ 'gender' ]            = business.contact_gender
    data[ 'month' ]             = Date::MONTHNAMES[business.contact_birthday.month]
    data[ 'day' ]               = business.contact_birthday.day
    data[ 'year' ]              = business.contact_birthday.year
    data[ 'country' ]           = 'United States'
    data[ 'language' ]          = 'English'
    data[ 'password' ]          = Yahoo.make_password
    data[ 'secret_answer_1' ]   = Yahoo.make_secret_answer1
    data[ 'secret_answer_2' ]   = Yahoo.make_secret_answer2
    data[ 'phone' ]             = business.local_phone
    data[ 'email' ]             = business.user.email
    data[ 'business_email' ]    = business.contact_email
    data[ 'business_address' ]  = business.address + ' ' + business.address2
    data[ 'business_city' ]     = business.city
    data[ 'business_state' ]    = business.state
    data[ 'business_zip' ]      = business.zip
    data[ 'business_website' ]  = business.company_website
    data[ 'business_phone' ]    = business.local_phone
    data[ 'business_category' ] = business.yahoo_category
    data[ 'fax_number' ]        = business.fax_number
    data[ 'year_established' ]  = business.year_founded
    data[ 'payment_methods' ]   = Yahoo.payment_methods(business)
    data[ 'languages_served' ]  = 'English'
  end
end
