class Scanner
  include HTTParty
  digest_auth 'api', '13fc9e78f643ab9a2e11a4521479fdfe'

  base_uri ENV['SCAN_SERVER'] || 'scan.netversa.com'
  
  # the AWS beanstalk instance weston setup
  # base_uri 'scan-mri-staging-2hpbtmyw2a.elasticbeanstalk.com'

  debug_output $stderr

  def initialize(report)
    @report              = report
    @site                = report.site
    @location            = Location.where(:zip => report.zip).first
    @data                = {}
    @data['business']    = report.business
    @data['phone']       = report.phone
    @data['zip']         = report.zip
    @data['latitude']    = @location.latitude
    @data['longitude']   = @location.longitude
    @data['state']       = Carmen::state_name( @location.state )
    @data['state_short'] = @location.state
    @data['city']        = @location.city
    @data['county']      = @location.county
    @data['country']     = @location.country
  end

  def run
    options = {
      :query => {:payload_data => @data.to_json, :site => @site},
      :headers => { 'content-length' => '0' }
    }
    begin
      response = self.class.post("/scan.json", options)
    rescue
      error_message = 'Failed'
      status = 'error'
      response = {
        'error' => 'Failed'
      }
    end

    status = nil
    result = nil
    listed_phone = nil
    listed_address = nil
    listed_url = nil
    error_message = nil
    request_time = nil

    if response['error']
      error_message  = response['error']
      status         = 'error'
    else
      result         = response['result']
      if result.is_a? Hash
        status         = result['status']
        listed_phone   = result['listed_phone']
        listed_address = result['listed_address']
        listed_url     = result['listed_url']
      else
        error_message = 'Not supported'
        status = 'error'
      end
    end

    Scan.create do |s|
      s.report_id      = @report.id
      s.status         = status
      s.site           = @site
      s.business       = @data['business']
      s.phone          = @data['phone']
      s.zip            = @data['zip']
      s.latitude       = @data['latitude']
      s.longitude      = @data['longitude']
      s.state          = @data['state']
      s.state_short    = @data['state_short']
      s.city           = @data['city']
      s.county         = @data['county']
      s.country        = @data['country']
      s.listed_phone   = listed_phone
      s.listed_address = listed_address
      s.listed_url     = listed_url
      s.request_time   = request_time
      s.error_message  = error_message
    end
  end
end
