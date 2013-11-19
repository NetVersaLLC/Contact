namespace :payloads do
  task :make_package => :environment do
    Site.all.each do |site|
      Package.all.each do |package|
			  PackagePayload.create do |pp|
				  pp.site_id = site.id
          pp.package_id = package.id
				end
      end
    end
  end
  task :import => :environment do
    db = Rails.configuration.database_configuration
    STDERR.puts "Erasing database...";
    ActiveRecord::Base.connection.execute("ALTER TABLE #{db[Rails.env]['database']}.payloads auto_increment=1")
    Payload.delete_all
    signup = Mode.find_by_name("SignUp")
    STDERR.puts "signup: #{signup}"
    STDERR.puts "Done. Beginning import..."
    make_path = lambda do |payload|
      "sites/#{payload}/client_script.rb"
    end
    get_children = lambda do |code|
      if match = code.match(/self\.start\(?\s*["']([^"'+]+)["']\s*\)?/i)
        return match.captures.map { |payload| make_path.call(payload) }
      else
        return []
      end
    end
    parse_filename = lambda do |file|
      file.match(/sites\/([^\/]+)\/([^\/]+)/).captures
    end
    set_sitename = lambda do |site_name|
      site = Site.find_by_name(site_name)
      if site.nil?
        print "What is the right site name for: #{site_name}: "
        site_name = STDIN.gets.strip
        site = Site.find_by_name(site_name)
      end
      return site
    end
    add_payload = lambda do |parent_id, script|
      STDERR.puts "Adding: #{script}: parent: #{parent_id.nil? ? 'nil' : parent_id}"
      data_generator_file = script.split("/")[0 .. -2].join("/") + "/data_generator.rb"
      data_generator = nil
      if File.exists? data_generator_file
        data_generator = File.read data_generator_file
      end
      client_script = File.read script
      site_name, payload_name = *parse_filename.call(script)
      site = nil
      site = Site.find_by_name(site_name)
      if site.nil?
        # If site not in DB then remove git
        system "rm -rf sites/#{site_name}"
        return
      end

      if Payload.where(:name => payload_name, :site_id => site.id, :mode_id => signup.id).count == 0
        parent = Payload.create do |p|
          p.parent_id      = parent_id
          p.site_id        = site.id
          p.mode_id        = signup.id
          p.active         = false
          p.client_script  = client_script
          p.data_generator = data_generator
          p.name           = payload_name
        end
        get_children.call(client_script).each do |child_script|
          if child_script.downcase.strip == script.downcase.strip
            STDERR.puts "Skipping recursive call to: '#{child_script}': '#{script}'"
            next
          end
          add_payload.call(parent.id, child_script)
        end
      end
    end
    STDERR.puts "Got to glob!"
    Dir.glob("sites/*/SignUp/client_script.rb").each do |script|
      add_payload.call(nil, script)
    end
  end
end
