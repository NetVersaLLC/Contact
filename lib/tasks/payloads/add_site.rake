namespace :payloads do
  task :add_site => :environment do
    puts "Adding a new site, what's the site info?"
    print "Name: "
    site_name = STDIN.gets.strip
    print "domain: "
    domain = STDIN.gets.strip
    print "Model: "
    model = STDIN.gets.strip
    puts "Is this information correct?"
    puts "Name: #{site_name}"
    puts "Domain: #{domain}"
    puts "Model: #{model}"
    print "[y/N]: "
    answer = STDIN.gets.strip
    if answer == 'y'
      puts "Adding site!"
      site = Site.create do |s|
        s.name = site_name
        s.domain = domain
        s.model = model
      end
      site.save!
      exit
    end
    puts "Skipping add."
  end
end
