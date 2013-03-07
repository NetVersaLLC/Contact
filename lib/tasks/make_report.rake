namespace :business do
  task :report, [:business_id] => :environment do |t,args|
    business = Business.find(args[:business_id])
    Business.citation_list.each do |site|
      STDERR.puts "Site: #{site[0]}"
      if business.respond_to?(site[1]) and business.send(site[1]).count > 0
        business.send(site[1]).each do |thing|
          row = [site[3]]
          site[2].each do |name|
            if name[0] == 'text'
              row.push thing.send(name[1])
            end
          end
          puts row.join("\t")
        end
      else
        STDERR.puts "Nothing for: #{site[1]}"
      end
    end
  end

  task :spreadsheet, [:business_id] => :environment do |t,args|
    business = Business.find(args[:business_id])
  end


end
