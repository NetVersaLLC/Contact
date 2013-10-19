class Report < ActiveRecord::Base
  attr_accessible :business, :business_id, :completed_at, :name, :phone, :site, :started_at, :zip, :label_id
  has_many :scans
  belongs_to :label

  def create_scan_tasks
    if self.status == 'started'
      raise 'Report generation already started'
    end
    self.status = 'started'
    self.save!

    uri = URI('http://reports.savilo.com/TownCenter/leads.php')
    Net::HTTP.delay.post_form(uri, {:phone => self.phone, :zip => self.zip, :business_name => self.business,
                                    :email => self.email, :referrer_code => self.referrer_code})

    Delayed::Worker.logger.info "Starting performance: #{Time.now.iso8601}"

    SiteProfile.where(enabled_for_scan: true).pluck(:site).each do |site|
      scan = Scan.create_for_site(self.id, site)
    end

    Delayed::Worker.logger.info "Ending performance: #{Time.now.iso8601}"


    self
  end

  def self.generate(business, zip, phone, package_id, ident, label, email, referral)
    report = self.create do |r|
      r.business      = business
      r.zip           = zip
      r.phone         = phone
      r.package_id    = package_id
      r.ident         = ident
      r.label         = label
      r.email         = email
      r.referrer_code = referral
    end
    report.create_scan_tasks
    report
  end

  # mark all completed reports as completed
  def self.update_statuses
    Report.where(:status => 'started').each do |report|
      unfinished_tasks_count = Scan.where(:report_id => report.id,
                                          :task_status => [Scan::TASK_STATUS_TAKEN, Scan::TASK_STATUS_WAITING]).count
      next unless unfinished_tasks_count == 0

      report.status = 'completed'
      report.completed_at = Time.now
      report.save!

      ReportMailer.report_email(report).deliver unless report.email.nil? || report.email.empty?
    end
  end
end

