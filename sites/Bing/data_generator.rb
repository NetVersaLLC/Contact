data = {}
data[ 'name' ]              = business.name
data[ 'city' ]              = business.city
data[ 'state_short' ]       = business.state
data[ 'state_full' ]        = business.state_name
data[ 'address' ]           = business.address + " " + business.address2
data[ 'zip' ]               = business.zip
data[ 'phone' ]             = business.phone
data[ 'country' ]           = 'United States'
data[ 'password' ]          = Bing.make_password
data[ 'secret_answer' ]     = Bing.make_secret_answer

data[ 'first_name' ]        = business.contact_first_name
data[ 'last_name' ]         = business.contact_last_name
data[ 'birth_month' ]       = Date::MONTHNAMES[business.contact_birthday.month]
data[ 'birth_day' ]         = business.contact_birthday.day
data[ 'birth_year' ]        = business.contact_birthday.year
data[ 'gender' ]            = business.contact_gender
data[ 'email' ]             = business.contact_email
data[ 'hotmail' ]           = nil # singed emails: hopak12312321@hotmail.com, hopak65201_98@hotmail.com

data[ 'category' ]          = Bing.get_category(business)
data[ 'toll_free_number' ]  = business.toll_free_number
data[ 'fax_number' ]        = business.fax_number
data[ 'website' ]           = business.company_website
data[ 'facebook' ]          = nil # NOTE: unimlemented
data[ 'twitter' ]           = nil # NOTE: unimplemented

data[ 'year_established' ]  = business.year_founded
data[ 'description' ]       = business.business_description
data[ 'languages' ]         = [ 'English' ]
data[ 'payments' ]          = Bing.make_payments(business)
data[ 'hours_monday_from' ] = '8:00'
data[ 'hours_monday_to' ]   = '8:00'


