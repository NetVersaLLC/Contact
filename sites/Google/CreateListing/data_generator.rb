data = {}
data[ 'email' ]           = business.googles.first.email
data[ 'password' ]        = business.googles.first.password
data[ 'business' ]        = business.business_name
data[ 'zip' ]             = business.zip
data[ 'phone' ]           = business.local_phone
data[ 'address' ]         = business.address
if business.address2
  data[ 'address' ] += ' ' + business.address2
end
data
