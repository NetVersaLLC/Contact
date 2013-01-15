data = {}
data[ 'email' ]			= business.ibegins.first.email
data[ 'password' ]		= business.ibegins.first.password
data[ 'business_name' ]		= business.business_name
data[ 'country' ]		= "United States"
data[ 'state_name' ]		= business.state_name
data[ 'city' ]			= business.city
data[ 'address' ]		= business.address + ' ' + business.address2
data[ 'zip' ]			= business.zip
data[ 'phone' ]			= business.local_phone
data[ 'fax' ]			= business.fax_number
data[ 'category1' ]		= "Restaurants"#business.category1
data[ 'category2' ]		= "Scuba"#business.category2
data[ 'category3' ]		= "Orchard"#business.category3
data[ 'url' ]			= business.company_website
data[ 'facebook' ]		= ""#business.facebooks.first.email
data[ 'twitter_name' ]		= ""#business.twitters.first.username
data[ 'desc' ]			= business.business_description[0 .. 245]
data[ 'brands' ]		= ""#
data[ 'products' ]		= ""#
data[ 'services' ]		= business.keyword1 + ', ' +business.keyword2 + ', ' +business.keyword3 + ', ' +business.keyword4 + ', ' +business.keyword5
data[ 'payment_methods' ]	= Ibegin.payment_methods( business )
data

