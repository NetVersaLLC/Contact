require 'httparty'

def search_google(business, zip)
    long = Location.where(:zip => zip).first.longitude
    lat = Location.where(:zip => zip).first.latitude
    location = "#{long}" + ',' + "#{lat}"
    #~ @auth_key = 'AIzaSyCBULo3dEbDt8B1rIG4bKgzkUNx5_ubgs4'

   params = {
      :key => @auth_key,
      :query => "#{business}",
      :location => "#{location}",
      :radius => 500,
      :sensor => false,
     }
   
   res = HTTParty.get("https://maps.googleapis.com/maps/api/place/textsearch/json", { :query => params })
  
    if res.success?
	business_listed = [:unlisted]
	res['results'].each do |business_name|
		if business_name["name"] == business
		  puts "Business is listed"
		  business_listed = [:listed]
	        end
	end
    else
	puts "Business is not listed"
    end
  return business_listed
  end
  
  