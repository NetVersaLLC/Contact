require 'json'
  namespace :zipperpage do
  task :categories => :environment do
body = File.open(Rails.root.join("categories", "Zipperpage", "categories.json"), 'r').read
    categories = JSON.parse(body)

    root = ZipperpageCategory.create(:name => 'root')
    categories.each do |k|
        node = Zipperpage.create(:name => k, :parent_id => root.id)
        puts(k)
    end
    end
  end
