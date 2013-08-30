namespace :examine do
  task :citation_list => :environment do
    business = Business.find(486)
    Business.citation_list.each do |data|
      data[2].each do |row|
        next unless row[0] == 'select'
        STDERR.puts "klass: #{row[1]}"
        klass = row[1].classify.constantize
        next if klass == GoogleCategory
        if row[1] =~ /category/
          obj = eval "business.#{data[1]}.first"
          unless obj == nil
            res = ActiveRecord::Base.connection.execute "SELECT #{row[1]}_id FROM #{data[1]} WHERE business_id=#{business.id} AND #{row[1]}_id IS NOT NULL"
            res.each do |row|
              STDERR.puts "Row: #{row.inspect}"
              category_name = klass.find(row[0]).name
              category_id   = row[0]
            end
          end
        end
      end
    end
  end
end
