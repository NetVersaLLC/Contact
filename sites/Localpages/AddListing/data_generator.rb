data = {}
data['username']		= business.localpages.first.username
data['password']		= business.localpages.first.password
data['business']		= business.business_name
data['category1']		= "Food & Dining"#business.category1
data['category2']		= "Asian Restaurants"#business.category2
data['address']			= business.address
data['address2']		= business.address2
data['city']			= business.city
data['state']			= business.state_name
data['zip']			= business.zip
data['phone']			= business.local_phone
data['website']			= business.company_website
data
