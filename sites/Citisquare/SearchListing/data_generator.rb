data = {}
data[ 'business' ]          = business.business_name
data[ 'city' ]              = business.city
data[ 'state_short' ]       = business.state
data[ 'zip' ]       = business.zip
data[ 'citystate' ] = data[ 'city' ] + ", " + data[ 'state_short' ]
data[ 'phone' ]             = business.local_phone
data