data = {}
catty                       = Digabusiness.where(:business_id => business.id).first
data[ 'category1' ]          = catty.digabusiness_category.parent.name.gsub("\n", "")
data[ 'category2' ]       = catty.digabusiness_category.name.gsub("\n", "")

data[ 'business' ]		= business.business_name
data[ 'website' ]		= business.company_website
data[ 'description' ]		= business.business_description
data[ 'fname' ]			= business.contact_first_name
data[ 'lname' ]			= business.contact_last_name
data[ 'fullname' ]		= data[ 'fname' ] + ' ' + data[ 'lname' ]
data[ 'email' ]			= business.bings.first.email
data[ 'addressComb' ]		= business.address + "  " + business.address2
data[ 'city' ]			= business.city
data[ 'state_name' ]		= business.state_name
data[ 'zip' ]			= business.zip
data[ 'phone' ]			= business.local_phone
data[ 'payments' ]		= Digabusiness.payment_methods(business)
data
