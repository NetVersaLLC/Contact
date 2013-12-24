class Rackspace

  def self.signature_header
    user_key = "S4UC3MxX1fnWNsRRUhEM"
    user_agent = "Ruby Test Client"
    timestamp = Time.now.strftime("%Y%m%d%H%M%S") #YYYYMMDDHHmmss
    shared_secret_key = "Nx5i0l7yxyDWNNRYSsrvHG45LiJxpmVsN6gb2W5c"

    # userkey useragent timestamp secret key 
    sha1 = Digest::SHA1.digest(user_key + user_agent + timestamp + shared_secret_key)
    sha1_base64 = Base64.encode64( sha1 )

    (user_key + ":" + timestamp + ":" + sha1_base64).strip
  end 


  def self.headers_auth_creds apiKey, secretKey
    userAgent = 'Ruby Test Client'
    timestamp = DateTime.now.strftime('%Y%m%d%H%M%S')

    data_to_sign = (apiKey + userAgent + timestamp + secretKey).strip

    hash = Base64.encode64(Digest::SHA1.digest(data_to_sign))
    signature = (apiKey + ":" + timestamp + ":" + hash).strip

    headers = Hash['Content-Type' => 'text/json', 'User-Agent' => userAgent, 'X-Api-Signature' => signature]
    #headers = Hash['User-Agent' => userAgent, 'X-Api-Signature' => signature]
  end

  def self.create_email
    RestClient.log = $stderr 

    apiKey    = 'S4UC3MxX1fnWNsRRUhEM'
    secretKey = 'Nx5i0l7yxyDWNNRYSsrvHG45LiJxpmVsN6gb2W5c'
    headers  = headers_auth_creds apiKey, secretKey
    puts headers

    #puts "trying"
    #response = RestClient.get "https://api.emailsrvr.com/v1/customers/1072840/domains/fxit.co/rs/mailboxes", headers
    #response = RestClient.get "https://api.emailsrvr.com/v0/customers/1072840/domains", headers
    #puts ">>" + response

    url = "https://api.emailsrvr.com/v1/customers/1072840/domains/fxit.co/rs/mailboxes/john.smith"
    password = 'JustAnotherDay2!'
    request =  {'size' => "25600", 'password' => password}
    puts request
    #response = RestClient.post(url, request, headers)
    response = RestClient.post(url, request, headers){ |response, request, result| puts response }

  end 

end 
