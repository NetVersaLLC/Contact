namespace :payloads do
  task :import => :environment do
    Payload.delete_all
    db = Rails.configuration.database_configuration
    signup = Mode.find_by_name("SignUp")
    get_children = lambda do |code|
      if match = code.match(/self\.start\(?\s*["']([^"'+]+)["']\s*\)?/i)
        return match.captures
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
    ActiveRecord::Base.connection.execute("ALTER TABLE #{db[Rails.env]['database']}.payloads SET auto_increment=1");
    Dir.glob("sites/*/SignUp/client_script.rb").each do |script|
      data_generator_file = script.split("/")[0 .. -2].join("/") + "/data_generator.rb"
      data_generator = nil
      if File.exists? data_generator_file
        data_generator = File.read data_generator_file
      end
      client_script = File.read script
      site_name, payload_name = *parse_filename(script)
      site = nil
      while site == nil
        site = set_sitename(site_name)
      end
      Payload.create do |p|
        p.site_id = site.id
        p.client_script = script
        p.name = name
      end
    end
  end
end
