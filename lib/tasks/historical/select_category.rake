namespace :categories do
  task :set => :environment do
    business = Business.find(ENV['business_id'])
    Business.citation_list.each do |data|
      data[2].each do |row|
        if row[0] == 'select'
          klass = row[1].classify.constantize
          next if klass == YahooCategory
          category_name = ''
          STDERR.puts "Checking: #{data[1]}"
          if business.send(data[1]) == nil
            data[0].constantize.create do |obj|
              obj.business_id = business.id
            end
            STDERR.puts "Created: #{data[0]}"
          end
          if business.send(data[1]).count > 0
            site = business.send(data[1]).first
            unless site
              STDERR.puts "Creating: #{data[1]}"
              site = business.send(data[1]).create do |obj|
                obj.business_id = business.id
              end
            end
            if site
              STDERR.puts "Site: #{row[1]}"
              category = site.send("#{row[1]}_id")
              if category
                STDERR.puts "CNAME: #{category}"
                category_name = klass.find(category).make_category
              else
                if klass.count > 0
                  category = klass.offset(rand(klass.count)).first.id
                  STDERR.puts "Setting: #{category}"
                  site.send("#{row[1]}_id=", category)
                  site.save(:validate => false)
                  category_name = klass.find(category).make_category
                else
                  STDERR.puts "No categories in: #{klass}"
                end
              end
            end
          end
          STDERR.puts "class: #{klass}: category_name: #{category_name}"
        end
      end
    end
  end
end
