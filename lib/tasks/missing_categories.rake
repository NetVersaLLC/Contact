namespace :categories do
  desc "List category tables that are empty."
  task :empty => :environment do

    puts "The following category tables are empty:" 
    empty_tables_found = false; 

    Rails.application.eager_load! 
    ActiveRecord::Base.descendants.each do |ar| 
      next unless ar.name.end_with?("Category")
      next unless ar.name != "SiteCategory"
      next unless ar.count == 0 

      empty_tables_found = true; 
      puts "\t#{ar.table_name}"
    end 

    puts "\tNone found." unless empty_tables_found
  end 
end 
