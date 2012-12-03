data = {}
seed = rand( 1000 ).to_s()
data[ 'email' ] 		= business.bings.first.email
data[ 'username' ] 		= business.bings.first.email
data[ 'password' ] 		= Yahoo.make_password
data[ 'phone' ] 		= business.local_phone
data[ 'link' ] 			= Yellowbot.check_email(business)
data[ 'business' ]		= business.business_name
data[ 'phone' ]			= business.local_phone
data[ 'address' ]		= business.address + ' ' + business.address2
data[ 'fax_number' ]		= business.fax_number
data[ 'city_name' ]		= business.city
data[ 'state' ]			= business.state
data[ 'zip' ]			= business.zip
data[ 'tollfree_number' ]	= business.toll_free_phone
data[ 'website' ]		= business.website
data[ 'hours_open' ]		= Getfav.consolidate_hours( business )
data
