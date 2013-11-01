namespace :showmelocal do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Showmelocal", "categories.json"), 'r').read
    categories = JSON.parse(body) 

    root = ShowmelocalCategory.create(:name => 'root')
    categories.each do |k| 
        node = ShowmelocalCategory.create(:name => k, :parent_id => root.id)  
        puts(k)
    end

 end
end 