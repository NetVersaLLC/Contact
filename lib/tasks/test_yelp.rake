namespace :yelp do
  task :test_yelp => :environment do
    y = Yelp.new
    y.business_id = 1
    y.cat = 'Category'
    y.subcat = 'Sub-Category'
    y.username = 'blah'
    y.save
  end
end
