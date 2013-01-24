data = {}
data[ 'business' ]		= business.business_name
data[ 'address' ]		= business.address
data[ 'address2' ]		= business.address2
data[ 'country' ]		= "United States"
data[ 'state' ]			= business.state_name
data[ 'city' ]			= business.city
data[ 'zip' ]			= business.zip
data[ 'phone' ]			= business.local_phone
data[ 'fax' ]			= business.fax_number
data[ 'email' ]			= business.bings.first.email
data[ 'website' ]		= business.company_website
data[ 'description' ]		= business.business_description
data[ 'keywords' ]		= business.keyword1 + ", " +business.keyword2 + ", " +business.keyword3 + ", " +business.keyword4 + ", " +business.keyword5
data[ 'fname' ]			= business.contact_first_name
data[ 'lname' ]			= business.contact_last_name
data[ 'position' ]		= "Business Owner / Senior Management"
data