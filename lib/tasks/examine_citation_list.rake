namespace :examine do
  task :citation_list => :environment do
    business = Business.find(203)
    bad_categories     = []
    bad_models         = []
    missing_javascript = []
    Business.citation_list.each do |data|
      begin
        # klass = data[0].classify.constantize
        klass = eval data[0]
      rescue Exception => e
        bad_models.push data[0]
      end
      data[2].each do |row|
        next unless row[0] == 'select'
        STDERR.puts "klass: #{row[1]}"
        begin
          # klass = eval row[1].camelize
          klass = eval row[1].camelize.constantize
          STDERR.puts klass
        rescue Exception => e
          bad_categories.push row[1].camelize
        end
        unless File.exists? Rails.root.join("public", "categories", "#{row[1].camelize}.js")
          missing_javascript.push row[1].camelize
        else
          STDERR.puts "Exists: #{row[1].camelize}"
        end
        next if klass == GoogleCategory
        if row[1] =~ /category/
          obj = eval "business.#{data[1]}.first"
          unless obj == nil
            res = ActiveRecord::Base.connection.execute "SELECT #{row[1]}_id FROM #{data[1]} WHERE business_id=#{business.id} AND #{row[1]}_id IS NOT NULL"
            res.each do |r|
              STDERR.puts "Row: #{row.inspect}"
              category_name = eval "obj.#{row[1]}.name"
              category_id   = r[0]
            end
          end
        end
      end
    end
    puts "Missing Javascript:"
    ap missing_javascript
    puts "Missing models:"
    ap bad_models
    puts "Missing categories:"
    ap bad_categories
  end
end
