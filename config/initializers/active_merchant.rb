# Test account login:
# https://test.authorize.net/
# Username: netversa411
# Password: ErK448qcKc 

::AUTHORIZENETGATEWAY = ActiveMerchant::Billing::Base.gateway(:authorize_net).new(
  :login    => "8g5FEvUR7De",
  :password => "3DYc4hBQ4gN856xv",
  :test     => true
)
::AUTHORIZENETGATEWAY.arb_live_url = 'https://apitest.authorize.net/xml/v1/request.api'
