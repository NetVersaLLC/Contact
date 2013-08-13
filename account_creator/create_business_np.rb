#!/usr/bin/env ruby
# encoding: UTF-8

require 'rubygems'
require 'awesome_print'
require 'faker'
require './config/environment'
require './account_creator/utility'


##
## Create User
##

##                                                   ##
### DO NOT USE THIS FOR PHONE VERIFICATION PAYLOADS ###
##                                                   ##



forwards_to = ARGV[0]
if forwards_to.nil?
  puts "For phone enabled verifies use ./account_creator/create_business.rb instead."
  puts "Usage: ./account_creator/create_business_np.rb <phone> <city> <state>"
  puts "Example: ./account_creator/create_business_np.rb 1111111111 Olathe Kansas"
  exit
end

ActiveRecord::Base.transaction do
number = ARGV[0].dup
#number = ARGV[0]
#Utility.get_number()
numb = {}

puts number


numb['ratecenter'] = ARGV[1]
numb['state'] = ARGV[2]
address =  Utility.get_address( numb )

ap number
ap address

STDERR.puts "Generating user..."

user = User.new
user.email = 'testuser'+rand(100000).to_s+'@netversa.com'

password = Utility.get_new_password
user.password = password
user.password_confirmation = password

user.label_id = Label.first.id
user.save!

##
## Create Subscription
##

STDERR.puts "Generating subscription..."

sub = Subscription.new
sub.package_id = 1
sub.tos_agreed = true
sub.active = true
sub.intial_fee = 0
sub.monthly_fee = 0
sub.label_id = Label.first.id
sub.save!


##
## Create Business
##

STDERR.puts "Generating business..."

business = Business.new

data = {}
data['business'] = Faker::Company.name

business.business_name = data['business']
business.corporate_name = data['business']
business.contact_gender = 'Female'
business.contact_prefix = 'Miss.'
business.contact_first_name = Faker::Name.first_name
business.contact_last_name = Faker::Name.last_name
business.local_phone = number
business.mobile_phone = business.local_phone

business_hash = address

business.address = business_hash['address']
business.address2 = 'Suite 6'
business.city = business_hash['city']
business.state = business_hash['state']
business.zip = business_hash['zip']

business.open_24_hours = true
business.open_by_appointment = false
business.monday_enabled = true
business.tuesday_enabled = true
business.wednesday_enabled = true
business.thursday_enabled = true
business.friday_enabled = true
business.saturday_enabled = true
business.sunday_enabled = true


business.monday_open = "08:00AM"
business.monday_close = "05:00PM"
business.tuesday_open = "08:00AM"
business.tuesday_close = "05:00PM"
business.wednesday_open = "08:00AM"
business.wednesday_close = "05:00PM"
business.thursday_open = "08:00AM"
business.thursday_close = "05:00PM"
business.friday_open = "08:00AM"
business.friday_close = "05:00PM"
business.saturday_open = "08:00AM"
business.saturday_close = "05:00PM"
business.sunday_open = "08:00AM"
business.sunday_close = "05:00PM"


business.accepts_cash = true
business.accepts_checks = true
business.accepts_mastercard = true
business.accepts_visa = true
business.accepts_discover = true
business.accepts_amex = true
business.accepts_diners = false
business.accepts_paypal = false
business.accepts_bitcoin = false

business.business_description = "If you’ve ever been a cable customer you’ve probably had the dissatisfaction of seeing you rates go up again and again. Check us out, you wont be dissapointed."

business.year_founded = Utility.generate_random_year
business.contact_birthday = "09/21/1975"#Utility.generate_birthday
business.category1 = "Cable Company"
business.category2 = "Telecommunications Contractor"
business.category3 = "Telecommunications Service Provider"
business.category4 = "Internet Service Provider"
business.category5 = "Telecommunications Equipment Supplier"
business.categorized = true
business.geographic_areas = 'Within 100 Miles'
business.company_website = "http://www."+data['business'].gsub(" ","").downcase

business.keywords = "Cable, Telecommunications, Service, Provider, Internet"
business.status_message = "We're a Cable Company. Come on down and buy some Cable."
business.services_offered = "Cable, Internet, Television"
business.trade_license = 1
business.trade_license_number = "19285434"
business.trade_license_locale = business.contact_first_name
business.trade_license_authority = Faker::Name.first_name
business.trade_license_expiration = "09-30-2025"
business.trade_license_description = "Telecommunications Provider Lisence"
business.brands = "Television Cable, Internet Service, Phone Provider"
business.tag_line = "Cable, Internet, Phone"
business.job_titles = "Cable Company"
#business.toll_free_phone = "800-456-6445"

business.user_id = user.id
business.subscription_id = sub.id
puts "ABout to save business"
business.save
puts business.errors.inspect
puts("Businesses saved")
puts business.id

business.create_site_accounts_test
puts business.inspect


model = Bing.where(:business_id => business.id).first
model.bing_category_id = 153
model.save!

model = Businessdb.where(:business_id => business.id).first
model.businessdb_category_id = 217
model.save!

model = Citisquare.where(:business_id => business.id).first
model.citisquare_category_id = 90
model.save!

model = Cornerstonesworld.where(:business_id => business.id).first
model.cornerstonesworld_category_id = 34
model.save!

model = Digabusiness.where(:business_id => business.id).first
model.digabusiness_category_id = 128
model.save!

model = Ebusinesspage.where(:business_id => business.id).first
model.ebusinesspage_category_id = 87
model.save!

model = Ezlocal.where(:business_id => business.id).first
model.ezlocal_category_id = 3099
model.save!

model = Foursquare.where(:business_id => business.id).first
model.foursquare_category_id = 15
model.save!

model = Ibegin.where(:business_id => business.id).first
model.ibegin_category_id = 1289
model.save!

model = Kudzu.where(:business_id => business.id).first
model.kudzu_category_id = 113
model.save!

model = Localcensus.where(:business_id => business.id).first
model.localcensus_category_id = 19
model.save!

model = Localdatabase.where(:business_id => business.id).first
model.localdatabase_category_id = 834
model.save!

model = Localizedbiz.where(:business_id => business.id).first
model.localizedbiz_category_id = 30
model.save!

model = Localpages.where(:business_id => business.id).first
model.localpages_category_id = 1005
model.save!

model = Magicyellow.where(:business_id => business.id).first
model.magicyellow_category_id = 1911
model.save!

model = Merchantcircle.where(:business_id => business.id).first
model.merchantcircle_category_id = 208
model.save!

model = Patch.where(:business_id => business.id).first
model.patch_category_id = 165
model.save!

model = Primeplace.where(:business_id => business.id).first
model.primeplace_category_id = 87
model.save!

model = Shopcity.where(:business_id => business.id).first
model.shopcity_category_id = 485
model.save!

model = Shopinusa.where(:business_id => business.id).first
model.shopinusa_category_id = 582
model.save!

model = Showmelocal.where(:business_id => business.id).first
model.showmelocal_category_id = 9
model.save!

model = Snoopitnow.where(:business_id => business.id).first
model.snoopitnow_category_id = 170
model.save!

model = Tupalo.where(:business_id => business.id).first
model.tupalo_category_id = 149
model.save!

model = Usbdn.where(:business_id => business.id).first
model.usbdn_category_id = 365
model.save!

model = Uscity.where(:business_id => business.id).first
model.uscity_category_id = 1264
model.save!

model = Usyellowpages.where(:business_id => business.id).first
model.usyellowpages_category_id = 3813
model.save!

model = Yellowassistance.where(:business_id => business.id).first
model.yellowassistance_category_id = 2479
model.save!

model = Yellowee.where(:business_id => business.id).first
model.yellowee_category_id = 311
model.save!

model = Yellowise.where(:business_id => business.id).first
model.yellowise_category_id = 734
model.save!

model = Yelp.where(:business_id => business.id).first
model.yelp_category_id = 317
model.save!

model = Yippie.where(:business_id => business.id).first
model.yippie_category_id = 1433
model.save!

model = Ziplocal.where(:business_id => business.id).first
model.ziplocal_category_id = 467
model.save!

model = Zipperpage.where(:business_id => business.id).first
model.zipperpage_category_id = 430
model.save!

model = Zippro.where(:business_id => business.id).first
model.zippro_category_id = 134
model.save!
 
model = Adsolutionsyp.where(:business_id => business.id).first
model.adsolutionsyp_category_id = 3034
model.save! 

model = AngiesList.where(:business_id => business.id).first
model.angies_list_category_id = 656
model.save!

model = Facebook.where(:business_id => business.id).first
model.facebook_category_id = 19
model.facebook_profile_category_id = 19
model.save!

model = Gomylocal.where(:business_id => business.id).first
model.gomylocal_category_id = 878
model.save!

model = InsiderPage.where(:business_id => business.id).first
model.insider_page_category_id = 540
model.save!

model = Yahoo.where(:business_id => business.id).first
model.yahoo_category_id = 246
model.save!

model = Yellowtalk.where(:business_id => business.id).first
model.yellowtalk_category_id = 402
model.save!

puts "Starting Sync"
task = Task.new
task.business_id = business.id
task.started_at = Time.now
task.save

STDERR.puts "*" * 78
STDERR.puts "  Generated new user: #{user.email}"
STDERR.puts "            password: #{password}"
STDERR.puts "        Subscription: #{sub.id}"
STDERR.puts "         Business ID: #{business.id}"
STDERR.puts "                 Key: #{user.authentication_token}"
STDERR.puts "*" * 78
ap business_hash
STDERR.puts "*" * 78

=begin
STDERR.puts "Ordering did: #{number['number']}"

VitelityNumber.create do |n|

    n.business_id = business.id
    n.ratecenter = number['ratecenter']
    n.state = number['state']
    n.did = number['number']
    n.address = business_hash['address']
    n.suite = "Suite 101"
    n.zip = business_hash['zip']
    n.forwards_to  = forwards_to
    n.active = true
end

Utility.order_number( number['number'] )
=end
end


