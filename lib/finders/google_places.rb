require 'httparty'

class GooglePlaces
  include HTTParty
  # debug_output $stderr
  base_uri "https://maps.googleapis.com"
  def initialize(api_key)
    @api_key = api_key
  end

  def search(lat, lon, name, args={})
    options = {
      :key => @api_key,
      :location => "#{lat},#{lon}",
      :radius => 50000,
      :sensor => false,
      :name => name
    }
    options.merge!(args)
    self.class.get("/maps/api/place/search/json", { :query => options })
  end
  def lookup(reference, args={})
    options = {
      :key => @api_key,
      :reference => reference,
      :sensor => false
    }
    options.merge!(args)
    self.class.get("/maps/api/place/details/json", { :query => options })
  end
end
