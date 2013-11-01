require 'open-uri'
require 'json'

def name_path_to_file(name_path)
  file = Rails.root.join('categories', 'bing', 'cats', name_path.gsub(/[^A-Za-z0-9]/, '') + '.json' )
  JSON.parse( File.open(file).read )
end

def recurse_load(parent, name_path)
  cats = name_path_to_file(name_path)
  cats.each do |cat|
    name = cat['Formatted Name'].gsub(/&amp;/, '&')
    puts "Creating: #{name}"
    child = parent.children.create(:name => name, :name_path => cat['NamePath'])
    if cat['SubNodeCount'] > 0
      recurse_load(child, cat['NamePath'])
    end
  end
end

namespace :bing do
  task :load_categories => :environment do
    root = BingCategory.create(:name => 'root')
    recurse_load(root, "ApplicationStructureContentCategoriesBusinessMaster")
  end
end
