class Scan < ActiveRecord::Base
  belongs_to :report

  def self.make_scan(data,site)
    options = {
      :query   => {
        :payload_data => data.to_json,
        :site         => site
      },
      :headers => { 'content-length' => '0' }
    }

    status         = nil
    error_message  = nil
    response       = nil
    begin
      Timeout::timeout(15) do
        response = Scanner.post("/scan.json", options)
        Delayed::Worker.logger.info "#{site}: Response: #{response.inspect}"
      end
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
      if row[0] == self.site
        return row[3]
      end
    end
    return self.site
  end
end
