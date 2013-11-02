namespace :categories do
  task :classify => :environment do
    #
    # Replaced this script with bin/cp_to_google_categories.pl
    #
    Business.where(:categorized => true).each do |business|
      STDERR.puts "Working on #{business.id}: #{business.category1}"
      cat = GoogleCategory.where(:name => business.category1).first
      if cat == nil
        puts "Skipping: #{business.id}: #{business.category1}"
        next
      end
      Business.citation_list.each do |data|
        STDERR.puts "Does it respond to #{data[1]}?"
        next if data[1] == 'googles'
        next if data[1] == 'snoopitnows'
        if business.send(data[1]).count > 0
          obj = business.send(data[1]).first
          data[2].each do |row|
            if row[0] == 'select'
              STDERR.puts "Setting: #{row[1]}"
              cat.send "#{row[1]}_id=", obj.id
            end
          end
        else
          STDERR.puts "No!"
        end
      end
    end
  end
end
