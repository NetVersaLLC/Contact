require 'httparty'

#~ Example
#~ search_yahoo('The Grand Hotel', 94087)

def search_yahoo(business, zip)
   #~ @auth_key = 'oDHt.YHV34EMqu3SV3e1X5ggpvad.0xA9CLFMztr8Th71AwpD6SAx1VcCIi.mXsLww--'

   params = {
      :appid => @auth_key,
      :query => "#{business}",
      :zip => zip,
      :output => 'json',
      :results => 10,
     }
   
   res = HTTParty.get("http://local.yahooapis.com/LocalSearchService/V3/localSearch", { :query => params })

   data = res['ResultSet']['Result']
    if res.success? && data != nil
	business_listed = [:unlisted]
	data.flatten.each do |business_name|
		if business_name['Title'] == business
		  puts "Business is listed"
		  business_listed = [:listed]
	        end
	end
    else
	puts "Business is not listed"
    end
  return business_listed
end