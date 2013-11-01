namespace :categories do
  task :google => :environment do
    data = JSON.parse( File.open(Rails.root.join("categories", "google", "final_list.js")).read )
    data.each_key do |key|
      puts "#{key}: #{data[key]}"
      GoogleCategory.create do |c|
        c.slug = key
        c.name = data[key]
      end
    end
  end
end
