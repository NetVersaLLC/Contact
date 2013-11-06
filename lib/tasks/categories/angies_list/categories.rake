namespace :angies_list do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "AngiesList", "categories.json"), 'r').read
    categories = JSON.parse(body) 

    root = AngiesListCategory.create(:name => 'root')
    categories.each do |k| 
        node = AngiesListCategory.create(:name => k, :parent_id => root.id)  
        puts(k)
    end

 end
end 