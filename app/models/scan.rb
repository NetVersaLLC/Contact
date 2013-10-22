require 'json'

class Scan < ActiveRecord::Base
  belongs_to :report
  belongs_to :site_profile

  TASK_STATUS_WAITING = 0
  TASK_STATUS_TAKEN = 1
  TASK_STATUS_FINISHED = 2
  TASK_STATUS_FAILED = 3

  def self.create_for_site(report_id, site_profile)
    report = Report.find(report_id)
    location = Location.where(:zip => report.zip).first
    self.create do |s|
      s.report_id      = report_id
      s.site           = site_profile.site
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

      s.site_profile   = site_profile
    end
  end

  def self.resend_long_waiting_tasks!
    self.where("task_status = :task_status AND updated_at < :updated_at", {
        task_status: Scan::TASK_STATUS_TAKEN,
        updated_at: DateTime.current - Contact::Application.config.scan_task_resend_interval
    }).each do |s|
      s.send_to_scan_server_in_thread!
    end
  end

  def self.fail_tasks_that_waiting_too_long!
    self.where("task_status = :task_status AND created_at < :created_at", {
        task_status: Scan::TASK_STATUS_TAKEN,
        created_at: DateTime.current - Contact::Application.config.scan_task_fail_interval
    }).update_all({task_status: Scan::TASK_STATUS_FAILED})
  end

  def self.send_all_waiting_tasks!
    self.where("task_status = :task_status", {
        task_status: Scan::TASK_STATUS_WAITING
    }).each do |s|
      s.send_to_scan_server_in_thread!
    end
  end

  def format_data_for_scan_server
    {
      :scan => @attributes.symbolize_keys.slice(:id, :business, :phone, :zip, :latitude, :longitude,
                                              :state, :state_short, :city, :county, :country),
      :site => site,
      :callback_host => Contact::Application.config.scanserver['callback_host'],
      :callback_port => Contact::Application.config.scanserver['callback_port']
    }
  end

  def send_to_scan_server_in_thread!
    ActiveRecord::Base.connection_pool.release_connection()
    Thread.new(self) { |t|
      begin
        t.send_to_scan_server!
      rescue => e
        puts "thread died with exception: #{e}: #{e.backtrace.join("\n")}"
      end
    }
  end

  def send_to_scan_server!
    status         = nil # are this vars really necessary ?
    error_message  = nil # are this vars really necessary ?
    response       = nil # are this vars really necessary ?
    resulting_status = TASK_STATUS_TAKEN
    begin
      base_uri = Contact::Application.config.scanserver['server_uri']
      if base_uri[-1] == '/'
        base_uri = base_uri[0..-2]
      end
      response = HTTParty.post("/scan.json", {
          :query   => format_data_for_scan_server,
          :headers => { 'Content-Length' => '0' },
          :timeout => 5,
          :base_uri => base_uri,
          :digest_auth => {
              :username => Contact::Application.config.scanserver['api_username'],
              :password => Contact::Application.config.scanserver['api_token'],
          }
      })
      unless response['error'].nil?
        resulting_status = TASK_STATUS_FAILED
        write_attribute(:error_message, response['error'])
      end
    rescue => e
      if [SocketError, Errno::ECONNREFUSED].include?(e.class)
        resulting_status = TASK_STATUS_WAITING
      else
        # task shouldn't fail in cases when scanserver went down for small time interval
        resulting_status = TASK_STATUS_FAILED
      end
      write_attribute(:error_message, "#{site}: #{e.message}: #{e.backtrace.join("\n")}")
    end
    write_attribute(:task_status, resulting_status)
    save!
    ActiveRecord::Base.connection_pool.release_connection()
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

