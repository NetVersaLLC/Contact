data = {}
data[ 'name' ]			= "Test9827398237479"#business.business_name
data[ 'city' ]			= business.city
data[ 'state' ]			= business.state
data[ 'address' ]		= business.address
data[ 'address2' ]		= business.address2
data[ 'zip' ]			= business.zip
data[ 'phone' ]			= business.local_phone
data[ 'website' ]		= business.company_website
data[ 'email' ]			= business.bings.first.email
google1 = GoogleCategory.where(:name => business.category1).first
google2 = GoogleCategory.where(:name => business.category2).first
data[ 'cat1' ] = YelpCategory.find(google1.yelp_category_id).name
data[ 'cat2' ] = YelpCategory.find(google2.yelp_category_id).name
data
