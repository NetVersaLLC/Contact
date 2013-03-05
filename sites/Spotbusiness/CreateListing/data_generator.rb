data 			= {}
data[ 'email' ]		= business.bings.first.email 
data[ 'password' ]	= Yahoo.make_password
data[ 'first_name' ] 	= business.contact_first_name
data[ 'last_name' ] 	= business.contact_last_name
data[ 'full_name' ] 	= data[ 'first_name' ] +' '+ data[ 'last_name' ] 
data[ 'address' ] 	= business.address + ' ' + business.address2
data[ 'city' ] 		= business.city
data[ 'state' ] 	= business.state
data[ 'zip' ] 		= business.zip
data[ 'business' ] 	= business.business_name
data[ 'profile_type'] 	= 'profile_right_wht'
data[ 'business_category' ] = business.category1
data['twitter_account'] = business.twitters.first.username
data
