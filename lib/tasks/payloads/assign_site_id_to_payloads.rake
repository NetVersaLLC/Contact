namespace :utils do
  task :bowow => :environment do
    Payload.where(:site_id => nil).each do |payload|
      site_name, payload_name = *payload.name.split("/")
      puts "Working on: #{site_name}: #{payload_name}"
      Site.all.each do |site|
        if site.name.gsub(/\s+/, '').to_s.downcase =~ /#{site_name.downcase}/i
          payload.name = payload_name
          payload.site_id = site.id
        end
      end
      if payload.site_id != nil
        puts "Site id found: #{payload.name}: #{payload.site_id}"
        payload.save
      else
        puts "What is the site id for: #{site_name}? "
        print " : "
        site_id = STDIN.gets.strip
        payload.site_id = site_id
        payload.name = payload_name
        payload.save
      end
    end
  end
end
