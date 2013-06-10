class Report < ActiveRecord::Base
  include Backburner::Queue
  queue "reports"  # defaults to 'newsletter-job'
  queue_priority 1000
  attr_accessible :business, :business_id, :completed_at, :name, :phone, :site, :started_at, :zip
  has_many :scans

  def self.perform(report_id)
    report = Report.find(report_id)
    # site_list     = %w/Google Bing Yahoo Yelp Citisquare Cornerstonesworld Discoverourtown Expressbusinessdirectory Getfave Ibegin Localizedbiz Yellowee Tupalo Justclicklocal Localpages Insiderpages/
    site_list     = %w/Google Yahoo Yelp Cornerstonesworld Discoverourtown Expressbusinessdirectory Ibegin Localizedbiz Yellowee Tupalo Localpages/
    site_list.each do |site|
      report.site = site
      scan        = Scanner.new(report)
      result      = scan.run
    end
    report.completed_at = Time.now
    report.save!
    return report
  end

  def self.generate(business, zip, phone, package_id, ident)
    report = Report.create do |r|
      r.business   = business
      r.zip        = zip
      r.phone      = phone
      r.package_id = package_id
      r.ident      = ident
    end
    Report.perform(report)
    # Backburner.enqueue Report, report.id
    report
  end
end

