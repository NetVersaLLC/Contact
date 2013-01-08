data = {}
data[ 'business' ]		= business.business_name
data[ 'addressComb' ]		= business.address + "  " + business.address2
data[ 'zip' ]			= business.zip
data[ 'phone' ]			= business.local_phone
data[ 'fax' ]			= business.fax_number
data[ 'email' ]			= business.bings.first.email
data[ 'website' ]		= business.company_website
data[ 'category1' ]		= "Restaurants-Food Delivery"#business.category1
data
