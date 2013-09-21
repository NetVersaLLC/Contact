class Scanner
  include HTTParty
  digest_auth 'api', '13fc9e78f643ab9a2e11a4521479fdfe'
  base_uri ENV['SCAN_SERVER'] || Contact::Application.config.scan_server

  debug_output $stderr

  def self.scan(report_id, site)
    @report              = Report.find(report_id)
    @site                = site
    @location            = Location.where(:zip => @report.zip).first
    @data                = {}
    @data['business']    = @report.business
    @data['phone']       = @report.phone
    @data['zip']         = @report.zip
    @data['latitude']    = @location.latitude
    @data['longitude']   = @location.longitude
    @data['state']       = Carmen::state_name( @location.state )
    @data['state_short'] = @location.state
    @data['city']        = @location.city
    @data['county']      = @location.county
    @data['country']     = @location.country

    request_time   = nil
    result         = nil
    listed_phone   = nil
    listed_address = nil
    listed_url     = nil
    status         = nil
    error_message  = nil

    response,status,error_message = Scan.make_scan(@data, @site)

    if response['error']
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

    Delayed::Worker.logger.info "#{@site}: #{Time.now.iso8601}"

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
