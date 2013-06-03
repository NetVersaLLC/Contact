class Report < ActiveRecord::Base
  attr_accessible :business, :business_id, :completed_at, :name, :phone, :site, :started_at, :zip
  has_many :scans

  def self.generate(business, zip, phone, package_id, ident)
    site_list     = %w/Ibegin Yelp Localcom/
    report = Report.create do |r|
      r.business   = business
      r.zip        = zip
      r.phone      = phone
      r.package_id = package_id
      r.ident      = ident
    end
    site_list.each do |site|
      report.site = site
      scan        = Scanner.new(report)
      result      = scan.run
    end
    report.completed_at = Time.now
    report.save!
    return report
  end
end
