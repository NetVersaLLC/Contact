namespace :categories do
  desc "Raise an error if any tables are missing."
  task :are_valid => :environment do
    empty_tables = []
    
    Rails.application.eager_load!
    ActiveRecord::Base.descendants.each do |ar|
      
      next unless ar.name.end_with?("Category")
      next unless ar.name != "SiteCategory"
      next unless ar.count == 0
      
      empty_tables.push ar
    end
     
    if empty_tables.length > 0
      raise "Empty Tables: #{empty_tables}"
    end
  end
end