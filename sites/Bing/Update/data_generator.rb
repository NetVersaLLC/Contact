data = {}
data[ 'name' ]              = business.name
data[ 'city' ]              = business.city
data[ 'state_short' ]       = business.state
data[ 'state_full' ]        = business.state_name
data[ 'address' ]           = business.address + " " + business.address2
data[ 'zip' ]               = business.zip
data[ 'phone' ]             = business.phone
data[ 'country' ]           = 'United States'
data[ 'hotmail' ]           = business.bings.first.email
data[ 'password' ]          = business.bings.first.password

data[ 'category' ]          = Bing.get_category(business)
data[ 'toll_free_number' ]  = business.toll_free_number
data[ 'fax_number' ]        = business.fax_number
data[ 'website' ]           = business.company_website
data[ 'facebook' ]          = '' # NOTE: unimlemented
data[ 'twitter' ]           = '' # NOTE: unimplemented

data[ 'year_established' ]  = business.year_founded
data[ 'description' ]       = business.business_description
data[ 'languages' ]         = [ 'English' ]
data[ 'payments' ]          = Bing.make_payments(business)
# data[ 'hours_monday_from' ] = '8:00'
# data[ 'hours_monday_to' ]   = '8:00'
