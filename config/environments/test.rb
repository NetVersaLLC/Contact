Contact::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  # used to authenticate scan server callbacks
  config.scan_server_uri = 'http://localhost:4567/'
  config.scan_server_api_username = 'api'
  config.scan_server_api_token = '892457gh9q87fah98ef7hq987harhq9w87eh8'
  # period to wait before resending task that is waiting for result to scanserver again
  config.scan_task_resend_interval = 10.seconds
  # how much time to wait before considering scan as failed
  config.scan_task_fail_interval = 1.minute

  # used to authenticate scan server callbacks
  config.scan_api_token = '892457gh9q87fah98ef7hq987harhq9w87eh8'

  #config.active_record.time_zone_aware_attributes = true
end
