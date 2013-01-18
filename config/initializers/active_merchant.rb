# Test account login:
# https://test.authorize.net/
# Username: netversa411
# Password: ErK448qcKc 

if Rails.env == "production" or Rails.env == :production
  ActiveMerchant::Billing::Base.mode = :production
  ::AUTHORIZENETGATEWAY = ActiveMerchant::Billing::Base.gateway(:authorize_net).new(
    :login    => "5SJ7zUf5m2c3",
    :password => "3DEM54zqk68BbZ34",
    :test     => false
  )
  ::AUTHORIZENETGATEWAY.arb_live_url = 'https://api.authorize.net/xml/v1/request.api'
else
  ::AUTHORIZENETGATEWAY = ActiveMerchant::Billing::Base.gateway(:authorize_net).new(
    :login    => "8g5FEvUR7De",
    :password => "3DYc4hBQ4gN856xv",
    :test     => true
  )
  ::AUTHORIZENETGATEWAY.arb_live_url = 'https://apitest.authorize.net/xml/v1/request.api'
end
