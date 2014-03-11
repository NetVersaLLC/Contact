namespace :payloads do
  task :patch => :environment do
    payloads = {}
    PackagePayload.where(:package_id => 6).each do |pp|
      root = Payload.where(:parent_id => nil, :site_id => pp.site_id, :mode_id => 2).first
      #puts "#{pp.inspect}\n#{Site.find(pp.site_id).inspect}" if root.nil?
      next if root.nil?
      payloads["#{Site.find(pp.site_id).name}/#{root.name}"] = [0,0,0,0]
    end
    Business.all.each do |b|
      print "\rCurrent: #{b.id}    "
      payloads.each_key do |p|
        payloads[p][0] += 1
        failed    = FailedJob.where(:business_id => b.id, :name => p).count
        completed = CompletedJob.where(:business_id => b.id, :name => p).count
        if failed > 0
	  payloads[p][1] += 1
        end
        if completed > 0
	  payloads[p][2] += 1
        else
          next if p =~ /Update/i
          if b.bings.first and b.bings.first.email != nil
	    STDERR.puts "#{b.id}: #{p}"
	    jobs      = Job.where(:business_id => b.id, :name => p).count
            if jobs == 0
              Payload.add_to_jobs(b, p)
            end
          end
        end
      end
    end
    File.open("output.json", "w").write payloads.to_json
  end
end
