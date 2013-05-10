namespace :findthebest do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Findthebest", "categories.json"), 'r').read
    categories = JSON.parse(body) 

    root = FindthebestCategory.create(:name => 'root')
    categories.each do |k| 
        node = FindthebestCategory.create(:name => k, :parent_id => root.id)  
        puts(k)
    end

 end
end 