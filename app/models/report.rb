class Report < ActiveRecord::Base
  include Backburner::Performable
  queue "reports"
  queue_priority 1000
  attr_accessible :business, :business_id, :completed_at, :name, :phone, :site, :started_at, :zip
  has_many :scans

  def perform
    # site_list     = %w/Google Bing Yahoo Yelp Citisquare Cornerstonesworld Discoverourtown Expressbusinessdirectory Getfave Ibegin Localizedbiz Yellowee Tupalo Justclicklocal Localpages Insiderpages/
    uri = URI('http://reports.savilo.com/TownCenter/leads.php')
    res = Net::HTTP.post_form(uri, {:phone => self.phone, :zip => self.zip, :business_name => self.business})

    site_list     = %w/Google Yahoo Yelp Cornerstonesworld Discoverourtown Expressbusinessdirectory Ibegin Localizedbiz Yellowee Tupalo Localpages Getfave Uscity Insiderpage Zippro Gomylocal Uscity Kudzu Snoopitnow Justclicklocal Businessdb/
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

