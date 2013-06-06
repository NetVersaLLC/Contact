# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
# Refinery::Pages::Engine.load_seed

#Truncate all tables except schema_migrations
ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table};") unless table == "schema_migrations"
end

#Import categories from lib/tasks directory
require 'rake'

Dir["#{File.dirname(__FILE__)}/lib/tasks/*/*.rake"].sort.each { |ext| load ext }
@folders = Dir.glob("lib/tasks/*/")
for folder in @folders
    f = folder.split("/")
    rakeTask = f.last + ':categories'
    Rake::Task[rakeTask].invoke unless f.last == "yelp"
end

#label
@label = Label.new(:name=>'TownCenter1', :domain=>'towncenter.com')
@label.save(:validate=>false)

#coupon
@coupon = Coupon.new(:name=>'NetVersa, LLC.', :code=>'NETVERSA', :percentage_off => 100, :label_id => @label.id, :redeemed_count => 1, :allowed_upto => 99999)
@coupon.save(:validate=>false)

#owner user
@owner = User.create(:password => 'owner', :password_confirmation => 'owner', :email => 'owner@netversa.com', :label_id => @label.id, 
										 :access_level => "116390000", :authentication_token => 'iHzCZLzSnyKf8GZ4dd4URq')
@owner.save(:validate=>false)

#reseller user
@reseller = User.create(:password => 'reseller', :password_confirmation => 'reseller', :email => 'reseller@netversa.com', 
												:label_id => @label.id, :access_level => "535311", :authentication_token => 'iHzCZLzSnyddKf8GZ33URq')
@reseller.save(:validate=>false)

#admin user
@admin = User.create(:password => 'admin', :password_confirmation => 'admin', :email => 'admin@netversa.com', 
												  :label_id => @label.id, :access_level => "46118", :authentication_token => 'iHzCZLzSnyddKf8GZ22URq')
@admin.save(:validate=>false)

#package
@package = Package.create(:name => "Starter", :price => "299", :monthly_fee => "29", :label_id => @label.id)
@package.save(:validate=>false)

#subscriptions
@subscription = Subscription.create(:package_id => @package.id, :active => 1, :label_id => @label.id, :business_id => 1, 
																		:message => "Free subscription!", :status => "success", :transaction_event_id => 1)
@subscription.save(:validate=>false)

#payments
@payment = Payment.create(:status => "success", :business_id => 1, :label_id => @label.id, :message => "free checkout", :transaction_event_id => 1)

#transaction_events
@transaction_event = TransactionEvent.create(:subscription_id => @subscription.id, :payment_id => @payment.id, :status => "success", 
																						 :business_id => 1, :label_id => @label.id, :message => "Purchase complete")
@transaction_event.save(:validate=>false)

#owner business
@business = Business.create(:user_id => @owner.id, :business_name => "Washington Avenue Armory", :corporate_name => "Washington",
                             :contact_gender => "Male", :contact_first_name => "Owner", :contact_last_name => "Owner",
                             :local_phone => "518-512-5203", :mobile_phone => "555-555-1212", :zip => "12210", 
                              :business_description => "it is a family owned and operated buisness. Started by Crystal Stevens in Newport Beach, Ca Crystal’s Bakery is making its way....................",
                             :geographic_areas => "Worldwide", :year_founded => "2012", :category1 => "Bathroom Supply Store789", :category2 => "lkokl", :category3 => "Home Improvement Store",
                             :subscription_id => @subscription.id, :captcha_solves => "200", :label_id => @label.id, :keywords => 'k1', :status_message => 'msg', :brands => "b1", :tag_line => "t1",
                             :job_titles => "job title")
@business.save(:validate=>false)