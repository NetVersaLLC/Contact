class Report < ActiveRecord::Base
  include Backburner::Performable
  queue "reports"
  queue_priority 1000
  attr_accessible :business, :business_id, :completed_at, :name, :phone, :site, :started_at, :zip
  has_many :scans

  def perform
    # site_list     = %w/Google Bing Yahoo Yelp Citisquare Cornerstonesworld Discoverourtown Expressbusinessdirectory Getfave Ibegin Localizedbiz Yellowee Tupalo Justclicklocal Localpages Insiderpages/
    site_list     = %w/Google Yahoo Yelp Cornerstonesworld Discoverourtown Expressbusinessdirectory Ibegin Localizedbiz Yellowee Tupalo Localpages Getfave Uscity Insiderpages Zippro Ebusinesspages Gomylocal Uscity Kudzu Snoopitnow/
    site_list.each do |site|
      self.site = site
      scan        = Scanner.new(self)
      result      = scan.run
    end
    self.completed_at = Time.now
    self.save!
    return self
  end

  def self.generate(business, zip, phone, package_id, ident)
    report = Report.create do |r|
      r.business   = business
      r.zip        = zip
      r.phone      = phone
      r.package_id = package_id
      r.ident      = ident
    end
    report.async.perform
    # Backburner.enqueue Report, report.id
    report
  end
end

