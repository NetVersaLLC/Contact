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
    if response["status"] == "OK" 
      address = {}

      response["results"].each do |result|
        ac = result["address_components"]
        zip = ac.select{ |a| a['types'].include?("postal_code") }.first
        next if zip.nil? 

        address["zip"] = zip["short_nane"] 
        city = ac.select{ |a| a['types'].include?("locality")}.first
        city = ac.select{ |a| a['types'].include?("sublocality")}.first if city.nil? 
        city = city["short_name"] 

        address["city"] = city
        address["state"] = ac.select{ |a| a['types'].include?("administrative_area_level_1")}[0]["short_name"] 
      end 
    end 
    address if defined? address
  end 
end
