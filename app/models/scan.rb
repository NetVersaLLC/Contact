class Scan
  include HTTParty
  digest_auth 'api', '13fc9e78f643ab9a2e11a4521479fdfe'

  base_uri ENV['SCAN_SERVER'] || 'scan.netversa.com'
  
  # the AWS beanstalk instance weston setup
  # base_uri 'scan-mri-staging-2hpbtmyw2a.elasticbeanstalk.com'

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
  end

  def run
    unless @payload.data_generator.nil?
      business = @data
      @data = eval(@payload.data_generator)
    end
    STDERR.puts options.inspect
    options = { :query => {:payload => @payload.payload, :payload_data => @data }, 
      :headers => { 'content-length' => '0' }
    }
    self.class.post('/jobs.json', options)
  end
end
