data = {}
data[ 'email' ] = business.yahoos.first.email
data[ 'phone_area' ] = business.local_phone.split("-")[0]
data[ 'phone_prefix' ] = business.local_phone.split("-")[1]
data[ 'phone_suffix' ] = business.local_phone.split("-")[2]
data[ 'business' ] = business.business_name
data[ 'password' ] = business.yahoos.first.password
data[ 'state' ] = business.state_name
data[ 'zip' ] = business.zip
data[ 'description' ] = business.business_description
data[ 'first_name' ] = business.contact_first_name
data[ 'last_name' ] = business.contact_last_name
data[ 'address' ] = business.address + ' ' +business.address2
data[ 'city' ] = business.city
data[ 'category' ] = 'Legal'#business.category1
data[ 'sub_category' ] = 'Bail Bonds' #business.category2
data[ 'specials' ] = business.keyword1 + ' ' +business.keyword2 + ' ' +business.keyword3 + ' ' +business.keyword4 + ' ' +business.keyword5
data
