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
    site = nil
    if answer == 'y'
      puts "Adding site!"
      site = Site.create do |s|
        s.name = site_name
        s.domain = domain
        s.model = model
      end
      site.save!
    else
      puts "Skipping add."
      site = Site.find_by_name(model)
    end
    puts "Copy another model?"
    print "[y/N]: "
    answer = STDIN.gets.strip
    if answer == 'y'
      print "Old Domain: "
      old_domain = STDIN.gets.strip
      print "Old Model: "
      model_string = STDIN.gets.strip
      old_model = model_string.constantize
      oldsite = Site.find_by_name model_name
      Payload.where(:site_id => oldsite.id).each do |p|
        n = Payload.new
        n.name = p.name
        n.client_script = p.client_script
        n.client_script.gsub! model.to_s, site.model
        n.client_script.gsub! old_domain, domain
        n.data_generator = p.data_generator
        n.data_generator.gsub! model.to_s, site.model
        n.data_generator.gsub! model.underscore.to_s, site.model.underscore
        n.parent_id = p.parent_id
        n.position = p.position
        n.mode_id = p.mode_id
        n.site_id = site.id
        n.save
        puts "Adding: #{p.name}"
      end
      puts "Adding to Package Payloads"
      Package.all.each do |package|
        PackagePayload.create do |p|
          p.site_id = site.id
          p.package_id = package.id
        end
      end
      puts "Adding categories"
      system "be rails g model #{model_name}Category name:string parent_id:integer:index"
    end
  end
end
