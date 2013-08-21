class Report < ActiveRecord::Base
  attr_accessible :business, :business_id, :completed_at, :name, :phone, :site, :started_at, :zip,  :label_id
  has_many :scans
  belongs_to :label

  def perform
    uri = URI('http://reports.savilo.com/TownCenter/leads.php')
    res = Net::HTTP.post_form(uri, {:phone => self.phone, :zip => self.zip, :business_name => self.business})

    Delayed::Worker.logger.info "Starting performance: #{Time.now.iso8601}"
    SiteProfile.where(enabled_for_scan: true).pluck(:site).each do |site|
      Scanner.delay.scan(self.id, site)
    end

    sleep 30
    Delayed::Worker.logger.info "Ending performance: #{Time.now.iso8601}"

    self.completed_at = Time.now
    self.save!
    return self
  end

  def self.generate(business, zip, phone, package_id, ident, label) 
    report = Report.create do |r|
      r.business   = business
      r.zip        = zip
      r.phone      = phone
      r.package_id = package_id
      r.ident      = ident
      r.label      = label
    end
    report.delay.perform
    report
  end
end

