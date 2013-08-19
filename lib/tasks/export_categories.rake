namespace :export do
  task :categories => :environment do
    Business.citation_list.each do |data|
      data[2].each do |row|
        if row[0] == 'select'
          klass = row[1].classify.constantize
          #next if klass == GoogleCategory
          next unless klass == MeetlocalbizCategory
          STDERR.puts "Walking: #{klass}"
          obj = klass.root.walk
          path = Rails.root.join("public", "categories", "#{klass}.js")
          STDERR.puts "Writing: #{path}"
          File.open(path, "w") do |f|
            f.write "window.#{klass}=#{obj.to_json};"
          end
        end
      end
    end
  end
end
