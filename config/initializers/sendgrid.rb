config.action_mailer.default_url_options = { :host => 'towncenter.com' }
ActionMailer::Base.smtp_settings = {
  :user_name => "jamesdouglas",
  :password => "crowdGr1p",
  :domain => "towncenter.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
