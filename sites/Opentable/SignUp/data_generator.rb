data = {}
data[ 'first_name' ]        = business.contact_first_name
data[ 'last_name' ]         = business.contact_last_name
data[ 'phone_area' ]        = business.local_phone.split("-")[1]
data[ 'phone_prefix' ]      = business.local_phone.split("-")[2]
data[ 'phone_suffix' ]      = business.local_phone.split("-")[3]
data[ 'email' ]		    = User.find( business.user_id ).email
data[ 'business' ]	    = business.business_name
data[ 'city' ] 		    = business.city
data[ 'state' ] 	    = business.state_name
data[ 'zip' ] 	 	    = business.zip
data[ 'country' ]  	    = 'United States'
data
