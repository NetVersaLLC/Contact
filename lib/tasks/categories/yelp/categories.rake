require 'open-uri'
require 'json'

namespace :yelp do
  #task :load_categories do
  task :categories => :environment do
    #eval "OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE"
    #open('https://biz.yelp.com/category_tree_json?country=US',
    #     "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0") do |f|
    #  body = f.read
    #  File.open(Rails.root.join("doc", "yelp_categories.json"), 'w') do |c|
    #    c.write body
    #  end
    #end
    body = File.open(Rails.root.join("categories", "yelp", "yelp_categories.json"), 'r').read
    categories = JSON.parse(body)
    root = YelpCategory.create(:name => 'root')
    categories.each do |row|
      title = row['t']
      c = row['c']
      cat = root.children.create(:name => title)
      puts "#{title}: #{c.length}"
      c.each do |sub|
        subtitle = sub['t']
        d = sub['c']
        sub = cat.children.create(:name => subtitle)
        puts "\t#{subtitle}: #{d.length}"
        d.each do |subsub|
          subsubtitle = subsub['t']
          e = subsub['c']
          bot = sub.children.create(:name => subsubtitle)
          e = [] unless e
          puts "YES" and exit if e.length > 0
          puts "\t\t#{subsubtitle}: #{e.length}"
        end
      end
    end
  end
end
