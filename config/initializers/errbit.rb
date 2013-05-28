Airbrake.configure do |config|
  config.api_key = 'a70b18fc63f496544eddae979f1e68f6'
  config.host    = 'errors.netversa.com'
  config.port    = 80
  config.secure  = config.port == 443
end
#Airbrake.configure do |config|
#  config.api_key = '137c47d25745c236942489cda9e50b03'
#  config.host    = 'localhost'
#  config.port    = 3000
#  config.secure  = config.port == 443
#end
