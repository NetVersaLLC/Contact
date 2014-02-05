# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'awesome_print'
require 'turnip/capybara'
require 'rack/test'
require 'factory_girl'

require File.dirname(__FILE__) + "/factories1"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/acceptance/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include FactoryGirl::Syntax::Methods
  config.filter_run focus: true
  config.filter_run_excluding slow: true
  config.filter_run_excluding :broken => true
  config.run_all_when_everything_filtered = true


  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end


  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
   config.use_transactional_fixtures = false
  #config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # show descriptive text when run
  config.add_formatter 'documentation'

  # Clean up the database
  require 'database_cleaner'
  config.before(:suite) do
    #DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:suite) { FactoryGirl.reload }

  #config.before(:suite) do
  #  DatabaseCleaner[:active_record].clean_with(:truncation)
  #  DatabaseCleaner[:active_record].strategy = :truncation
  #end

  config.before(:all) do
    DatabaseCleaner.clean
  end


    # config.before(:all) do
    #   request.host! 'localhost'
    # end

end

def create_site_profiles
  FactoryGirl.create(:site, :name => "Foursquare")
  FactoryGirl.create(:site, :name => "Facebook")
  FactoryGirl.create(:site, :name => "Google")
  FactoryGirl.create(:site, :name => "Yelp")
  FactoryGirl.create(:site, :name => "Yahoo")
  FactoryGirl.create(:site, :name => "Bing")
end
