namespace :yelp do
  task :show_categories => :environment do
    YelpCategory.list.each do |node|
      puts node.join("\t")
    end
  end
end
