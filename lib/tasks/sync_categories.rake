namespace :sync do
  task :categories => :environment do
    Business.citation_list.each do |data|
      data[2].each do |row|
        if row[0] == 'select'
          klass = row[1].classify.constantize
          #next if klass == GoogleCategory
          next unless klass == MysheriffCategory

          if klass == AngiesListCategory
            fixedName = "angies_list"
          elsif klass == FacebookProfileCategory
            fixedName = "facebook_profile"
          elsif klass == InsiderPageCategory
            fixedName = "insider_page"
          else
            fixedName = klass.to_s.downcase.gsub("category","")
          end
          ActiveRecord::Base.connection.execute("TRUNCATE #{fixedName}_categories")
          Rake::Task["#{fixedName}:categories"].invoke

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
