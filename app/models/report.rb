class Report < ActiveRecord::Base
  attr_accessible :business, :business_id, :completed_at, :name, :phone, :site, :started_at, :zip
  has_many :scans

  def generate(business, zip, phone)
    site_list     = %w/Ibegin/
    report = Report.create do |r|
      r.business = business
      r.zip      = zip
      r.phone    = phone
    end
    site_list.each do |site|
      report.site = site
      scan = Scanner.new(report)
      result = scan.run
    end
  end
end
