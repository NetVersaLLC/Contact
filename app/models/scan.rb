class Scan < ActiveRecord::Base
  belongs_to :report

  TASK_STATUS_WAITING = 0
  TASK_STATUS_TAKEN = 1
  TASK_STATUS_FINISHED = 2
  TASK_STATUS_FAILED = 3

  def self.create_for_site(report_id, site)
    report = Report.find(report_id)
    location = Location.where(:zip => report.zip).first
    self.create do |s|
      s.report_id      = report_id
      s.site           = site
      s.task_status    = Scan::TASK_STATUS_WAITING
      s.business       = report.business
      s.phone          = report.phone
      s.zip            = report.zip
      s.latitude       = location.latitude
      s.longitude      = location.longitude
      s.state          = Carmen::state_name(location.state)
      s.state_short    = location.state
      s.city           = location.city
      s.county         = location.county
      s.country        = location.country
    end
  end

  def self.resend_long_waiting_tasks!
    self.where("task_status = :task_status AND updated_at < :updated_at", {
        task_status: Scan::TASK_STATUS_TAKEN,
        updated_at: DateTime.current - Contact::Application.config.scan_task_resend_interval
    }).each do |s|
      s.delay.send_to_scan_server!
    end
  end

  def self.delete_too_long_waiting_tasks!
    self.where("task_status = :task_status AND created_at < :created_at", {
        task_status: Scan::TASK_STATUS_TAKEN,
        created_at: DateTime.current - Contact::Application.config.scan_task_delete_interval
    }).destroy_all
  end

  def format_data_for_scan_server
    {
      :scan => @attributes.symbolize_keys.slice(:id, :business, :phone, :zip, :latitude, :longitude,
                                              :state, :state_short, :city, :county, :country),
      :site => site
    }
  end

  def send_to_scan_server!
    status         = nil # are this vars really necessary ?
    error_message  = nil # are this vars really necessary ?
    response       = nil # are this vars really necessary ?
    begin
      response = HTTParty.post("/scan.json", {
          :query   => format_data_for_scan_server,
          :headers => { 'Content-Length' => '0' },
          :timeout => 5,
          :base_uri => ENV['SCAN_SERVER'] || Contact::Application.config.scan_server_uri,
          :digest_auth => {
              :username => Contact::Application.config.scan_server_api_username,
              :password => Contact::Application.config.scan_server_api_token,
          }
      })
      write_attribute(:task_status, TASK_STATUS_TAKEN)
      save!
      Delayed::Worker.logger.info "#{site}: Response: #{response.inspect}"
    rescue => e
      error_message = "#{site}: #{e.message}: #{e.backtrace.join("\n")}"
      status = 'error'
      response = {
        'error' => 'Failed'
      }
    end
    return response, status, error_message
  end

  def site_name
    Business.citation_list.each do |row|
      if row[0] == site
        return row[3]
      end
    end
    site
  end
end

