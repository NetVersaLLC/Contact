data = {}
data[ 'password' ]		= business.yellowises.first.password #DgyggRoMBZU
data[ 'username' ]		= business.yellowises.first.username
data[ 'city' ]			= business.city
data[ 'statename' ]		= business.state_name
data[ 'zip' ]			= business.zip
data[ 'business' ]		= business.business_name
data[ 'yearfounded' ]		= business.year_founded
data[ 'address' ]		= business.address
data[ 'address2' ]		= business.address2
data[ 'zipcode3' ]		= ""
data[ 'phone' ]			= business.local_phone
data[ 'altphone' ]		= business.mobile_phone
data[ 'fax' ]			= business.fax_number
data[ 'tollfree' ]		= business.toll_free_phone
data[ 'website' ]		= business.company_website.gsub("http://", "")
data[ 'description' ]		= business.business_description
data[ 'category' ]		= "Restaurants"
data[ 'keywords' ]		= business.keyword1 + "\n" + business.keyword2 + "\n" + business.keyword3 + "\n" + business.keyword4 + "\n" + business.keyword5
data
