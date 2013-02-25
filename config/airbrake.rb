Airbrake.configure do |config|
  config.api_key = 'a2a423207e9f937d53fb5762a734c2a3'
  config.host    = 'errors.netversa.com'
  config.port    = 80
  config.secure  = config.port == 443
end
