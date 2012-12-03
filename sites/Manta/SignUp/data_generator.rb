data = {}
data[ 'phone' ] = business.local_phone
data[ 'first_name' ] = business.contact_first_name
data[ 'last_name' ] = business.contact_last_name
data[ 'email' ] = 'netversatest125@gmail.com' #business.yahoos.first.email
data[ 'business' ] = business.business_name
data[ 'streetnumber' ] = business.address + ' ' + business.address2
data[ 'city' ] = business.city
data[ 'state' ] = business.state_name
data[ 'stateabreviation' ] = business.state
data[ 'zip' ] = business.zip
data[ 'country' ] = 'United States'
data[ 'countryAbrv' ] = 'US'
data[ 'citystate' ] = data[ 'city' ] + ', ' + data[ 'stateabreviation' ]
data[ 'password' ] = 'applesunday' #business.yahoos.first.password
data[ 'short_desc' ] = business.keyword1 + ' ' + business.keyword2 + ' ' + business.keyword3 + ' ' + business.keyword4 + ' ' + business.keyword5
data[ 'description' ] = business.business_description
data
