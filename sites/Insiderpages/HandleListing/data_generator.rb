data = {}
data[ 'business' ]		= business.business_name
data[ 'near_city' ]		= business.city + ', ' + business.state
data[ 'email' ]			= business.insider_pages.first.email
data[ 'password' ]		= business.insider_pages.first.password
data[ 'address' ]		= business.address + ' ' +business.address2
data[ 'city' ]			= business.city
data[ 'state' ]			= business.state
data[ 'zip' ]			= business.zip
data[ 'phone' ]			= business.local_phone
data[ 'business_email' ]	= data[ 'email' ]
data[ 'website' ]		= business.company_website
data[ 'business_description' ]	= business.business_description
data[ 'services' ]		= ""#services
data[ 'message' ]		= ""#Message to customers

data[ 'categories' ]		= ['Restaurants','Chinese Restaurants','Sushi Restaurants']#{business.category1,business.category2,business.category3}
data[ 'tags' ]			= ['sushi', 'asian buffet','asian cuisine']#[business.keyword1, business.keyword2, business.keyword3, business.keyword4, business.keyword5]

data
