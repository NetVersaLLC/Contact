#!/usr/bin/env ruby

require 'rubygems'
require 'yelpster'
require 'json'

def get_address( ratecenter, state )
  # ywsid = 'IRRAQuDAiFqFCPGrPzyA3Q'
  client = Yelp::Client.new
  request = Yelp::V2::Search::Request::Location.new(
    :term    => 'cable provider',
    :city => ratecenter,
    :state => state,
    :location => "#{ratecenter}, #{state}",
    :consumer_key => 'guxExEGc6q_CGmo8Xv44Bg',
      :consumer_secret => 'oxYRwyMK7jL2zVrMUjINlVti914',
      :token => '-neQfJo0y6Ie_mHaR_jq7UfiC2SHZPXN',
      :token_secret => '-8ruinaW1nedbv7fxTJ3d7NAihE'
  )
  response = client.search(request)
  # response = YAML::load_file('request.yml')
  f = File.open("request.yml", 'w')
  YAML::dump(response, f)
  business_hash = {}
  response['businesses'].each do |business|
    business_hash['address'] = response["businesses"][0]['location']["address"].join(" ")
    business_hash['city']    = response["businesses"][0]['location']["city"]
    business_hash['state']   = response["businesses"][0]['location']["state_code"]
    business_hash['zip']     = response["businesses"][0]['location']["postal_code"]
    break
  end
  puts business_hash.to_json
end

ratecenter = ARGV.shift
state      = ARGV.shift

get_address ratecenter, state
