require 'httparty'

# Method to check listing on citygripd. It need publisher code for using API. For testing , We an use 'test' as publisher code.
#example
#~ search_city_grid('The Grand Hotel','94087')

def search_city_grid(business, zip)

  params = {
      :what => "#{business}",
      :where => zip,
      :format => 'json',
      :publisher => @publisher_code,
     }
   
   res = HTTParty.get("http://api.citygridmedia.com/content/places/v2/search/where", { :query => params })

   data = res.parsed_response["results"]["locations"]
   
    if res.success? && data != nil
	business_listed = [:unlisted]
	data.flatten.each do |business_name|
		if business_name['name'] == business
		  puts "Business is listed"
		  business_listed = [:listed]
	        end
	end
    else
	puts "Business is not listed"
    end
  return business_listed
end
  
