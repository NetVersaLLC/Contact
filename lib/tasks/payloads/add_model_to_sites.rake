namespace :payloads do
  task :add_model_to_sites => :environment do
    Business.citation_list.each do |data|
      set_sitename = lambda do |site_name|
        site = Site.find_by_name(site_name)
        if site.nil?
          print "What is the right site name for: #{site_name}: "
          site_name = STDIN.gets.strip    
          site = Site.find_by_name(site_name)
        end
        return site
      end
      site = set_sitename.call(data[0])
      if site.name == data[0]
        next
      end
      site.model = data[0]
      site.save
    end
  end
end
