data = {}
data[ 'business' ]          = business['business']
data[ 'businessfixed' ]          = business['business'].gsub(" ", "+")
data[ 'city' ]              = business['city']
data[ 'state_short' ]       = business['state']
data[ 'citystate' ] = data[ 'city' ] + ", " + data[ 'state_short' ]
#data[ 'phone' ]             = business['local_phone']
data