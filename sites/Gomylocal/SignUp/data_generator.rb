data = {}
data[ 'username' ]		= business.bings.first.email.split("@")[0]
data[ 'password' ]		= Yahoo.make_password #z5U8O36s
data[ 'fname' ]			= business.contact_first_name
data[ 'lname' ]			= business.contact_last_name
data[ 'addressComb' ]		= business.address + "  " + business.address2
data[ 'zip' ]			= business.zip
data[ 'phone' ]			= business.local_phone
data[ 'state_name' ]		= business.state_name
data[ 'city' ]			= business.city
data[ 'keywords' ]		= business.category1 + ", " + business.category2 + ", " + business.category3 + ", " + business.category4 + ", " + business.category5
data[ 'email' ]			= business.bings.first.email
data[ 'hours' ]			= Localndex.get_hours(business)
data[ 'category1' ]		= "Restaurants"
data[ 'business' ]		= business.business_name
data
