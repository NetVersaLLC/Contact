#!/usr/bin/env ruby

require 'rubygems'
require 'awesome_print'
require 'faker'
#require 'yelpster'
require './config/environment'
require './account_creator/utility'
require './account_creator/vitelity.rb'

##
## Create User
##

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
    n.forwards_to  = "5735292536"
    n.active = true
end

Utility.order_number( number['number'] )

end
