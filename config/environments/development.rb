Contact::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Setting defautt action url
  config.action_mailer.default_url_options = {  :protocol => 'https',:host => 'towncenter.com' }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.log_level = :debug

  # credentials to access scan server
  # username and token are used for digest auth
  config.scan_server_uri = 'http://localhost:4567/'
  config.scan_server_api_username = 'api'
  config.scan_server_api_token = '13fc9e78f643ab9a2e11a4521479fdfe'

  # used to authenticate scan server callbacks
  config.scan_api_token = '892457gh9q87fah98ef7hq987harhq9w87eh8'


  config.paperclip_defaults = {
    :storage => :s3,
    :s3_protocol => 'https',
    :bucket => 'netversa',
    :s3_credentials => Rails.root.join( "config", "s3.yml")
  }
end
