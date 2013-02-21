data = {}
data[ 'business' ]          = business.business_name
data[ 'city' ]              = business.city
data[ 'state_short' ]       = business.state
data[ 'citystate' ] = data[ 'city' ] + ", " + data[ 'state_short' ]
data[ 'query' ] = data[ 'business' ] + " " + data[ 'citystate' ]
data[ 'phone' ]             = business.local_phone
data[ 'zip' ]       = business.zip
data[ 'bus_name_fixed'] 	= data[ 'business' ].gsub(" ", "+")
data