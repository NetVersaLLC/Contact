namespace :scan do
  task :report => :environment do
    site_list     = %w/Ibegin/
    report = Report.create do |r|
      r.business = 'Dutch Built'
      r.zip      = '78734'
      r.phone    = '512-828-7341'
    end
    site_list.each do |site|
      report.site = site
      scan = Scanner.new(report)
      result = scan.run
      ap result
      exit
    end
  end
end
