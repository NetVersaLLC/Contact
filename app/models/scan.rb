class Scan
  include HTTParty

  base_uri ENV['SCAN_SERVER'] || 'localhost:4567' #'scan.netversa.com'
  debug_output $stderr

  def initialize(site, business_name, zip)
    @payload             = Payload.new(site, 'SearchListing')
    @location            = Location.where(:zip => zip).first
    @data                = {}
    @data['business']    = business_name
    @data['zip']         = zip
    @data['latitude']    = @location.latitude
    @data['longitude']   = @location.longitude
    @data['state_short'] = @location.state
    @data['city']        = @location.city
    @data['county']      = @location.county
    @data['country']     = @location.country
    @auth                = {:username => 'api', :password => '13fc9e78f643ab9a2e11a4521479fdfe'}
  end

  def run
    unless @payload.data_generator.nil?
      business = @data
      @data = eval(@payload.data_generator)
    end
    options = { :basic_auth => @auth, :query => {:payload => @payload.payload, :payload_data => @data } }
    STDERR.puts options.inspect
    self.class.post('/jobs.json', options)
  end
end
