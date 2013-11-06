# encoding: UTF-8

namespace :db do 
  desc "This is for load site profile data  into site_profiles table"
  task :load_site_profiles => :environment do 
	
    site_data_file = Rails.root.join('doc', 'site_data.txt')
    unless File.exist?(site_data_file) && File.readable?(site_data_file)
      puts "#{site_data_file} is not existed or not readable "
      exit
    end

    # Remove existing records
    SiteProfile.destroy_all if SiteProfile.count > 0

    # Add new records with data from the file
    File.open(site_data_file, "r").drop(1).each do |line| 
      line.chop!
      line = line.lstrip.rstrip
      file, site, owner, founded, alexa_us_traffic_rank, page_rank, url, traffic_stats, notes = line.split('|')

      SiteProfile.create!(site: site, owner: owner, founded: founded,
                         alexa_us_traffic_rank: alexa_us_traffic_rank, page_rank: page_rank, url: url,
                         traffic_stats: traffic_stats, notes: notes)
    end 
  	
	end
end 



