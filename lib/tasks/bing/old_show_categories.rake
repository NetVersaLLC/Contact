namespace :bing do
  task :show_categories => :environment do
    BingCategory.list.each do |node|
      puts node.join("\t")
    end
  end
end
