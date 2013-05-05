class Location < ActiveRecord::Base
  # Its google, so you can get a wealth of information from a partial address search
  # params/input zip code = 93131 
  # or north%20beach%ca 
  # https://developers.google.com/maps/documentation/geocoding/
  #
  # returns nil if not found 
  def self.city_and_state_from_zip(search_zip) 
    # we can search on anything actually, but the expected behavior is by zip, so 
    # force that behavior 
    return nil unless /\d{5}(-\d{4})?$/ =~ search_zip

    request  = "http://maps.googleapis.com/maps/api/geocode/json?address=#{search_zip}&sensor=false"
    response = HTTParty.get(request) 

    return nil unless response["status"] == "OK" 

    address = nil
    response["results"].each do |result|
      ac = result["address_components"]
      country = ac.select{ |a| a['types'].include?("country") }.first
      next if country.nil? || country['short_name'] != "US" 

      address={}
      address["zip"] = ac.select{ |a| a['types'].include?("postal_code") }.first["short_name"]
      city = ac.select{ |a| a['types'].include?("locality")}.first
      city = ac.select{ |a| a['types'].include?("sublocality")}.first if city.nil? 
      city = city["short_name"] 

      address["city"] = city
      address["state"] = ac.select{ |a| a['types'].include?("administrative_area_level_1")}[0]["short_name"] 
    end 
    address if defined? address
  end 
end
