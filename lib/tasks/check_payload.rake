namespace :payloads do
  task :check, [:package_id] => :environment do |t,args|
    package = Package.find(args[:package_id])
    PackagePayload.where(:package_id => package.id).each do |p|
      begin
        payload = Payload.new(p.site, p.payload)
      rescue
        STDERR.puts "Payload does not exist: #{p.site}/#{p.payload}"
        p.delete
      end
    end
  end
end
