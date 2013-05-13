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

forwards_to = ARGV.shift
if forwards_to.nil?
  puts "Usage: ./account_creator/create_business.rb <forwarding phone>"
  puts "Example: ./account_creator/create_business.rb 5735292536"
  exit
end

ActiveRecord::Base.transaction do

number = Utility.get_number
address =  Utility.get_address( number )

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

business.business_name = Faker::Company.name
business.corporate_name = Faker::Company.name
business.contact_gender = 'Female'
business.contact_prefix = 'Miss.'
business.contact_first_name = Faker::Name.first_name
business.contact_last_name = Faker::Name.last_name
business.local_phone = "555-555-1212"

business_hash = address

business.address = business_hash['address']
business.address2 = 'Suite 101'
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
business.contact_birthday = Utility.generate_birthday
business.category1 = "Cable Company"
business.category2 = "Telecommunications Contractor"
business.category3 = "Telecommunications Service Provider"
business.category4 = "Internet Service Provider"
business.category5 = "Telecommunications Equipment Supplier"
business.categorized = true
business.geographic_areas = 'Within 100 Miles'

business.user_id = user.id
business.subscription_id = sub.id

business.save!

## Now set categories
model = AngiesList.where(:business_id => business.id).first
model.angies_list_category_id = 656
model.save!

model = Bing.where(:business_id => business.id).first
model.bing_category_id = 2778
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

model = Findthebest.where(:business_id => business.id).first
model.findthebest_category_id = 25
model.save!

model = Foursquare.where(:business_id => business.id).first
model.foursquare_category_id = 326
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

model = Spotbusiness.where(:business_id => business.id).first
model.spotbusiness_category_id = 4
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

STDERR.puts "*" * 78
STDERR.puts "Generated new user: #{user.email}"
STDERR.puts "          password: #{password}"
STDERR.puts "      Subscription: #{sub.id}"
STDERR.puts "       Business ID: #{business.id}"
STDERR.puts "*" * 78
ap business_hash
STDERR.puts "*" * 78

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

end

