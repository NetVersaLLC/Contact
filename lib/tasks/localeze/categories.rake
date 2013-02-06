namespace :localeze do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "Localeze", "categories.json"), 'r').read
    categories = JSON.parse(body) 

    root = LocalezeCategory.create(:name => 'root')
    categories.each do |k| 
        node = LocalezeCategory.create(:name => k, :parent_id => root.id)  
        puts(k)
    end

 end
end 