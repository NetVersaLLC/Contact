data = {}
seedString 			= rand( 1000 ).to_s()
data[ 'userName' ] 		= business.contact_first_name + business.contact_last_name + seedString
data[ 'email' ]			= 'netversatest74@yahoo.com'#'netversatest'+seedString+'@gmail.com'#business.yahoos.email.first
data[ 'pass' ]			= 'applesunday'
data[ 'securityQuestion' ]	= 'City of Birth?'
data[ 'answer' ] 		= 'Boston'
data[ 'prefix' ]		= business.contact_prefix
data[ 'firstName' ]		= business.contact_first_name
data[ 'lastName' ]		= business.contact_last_name
data[ 'businessName' ]		= business.business_name
data[ 'website' ]		= business.company_website
data[ 'busAddress1' ]		= business.address
data[ 'busAddress2' ]		= business.address2
data[ 'busCity' ]		= business.city
data[ 'busState' ]		= business.state
data[ 'busZip1' ]		= business.zip
data[ 'busNPA' ]		= business.local_phone.split("-")[0]
data[ 'busNXX' ]		= business.local_phone.split("-")[1]
data[ 'busPlusFour' ]		= business.local_phone.split("-")[2]
data[ 'busExtension' ]		= ''#TODO
data[ 'busFaxNPA' ]		= business.fax_number.split("-")[0]
data[ 'busFaxNXX' ]		= business.fax_number.split("-")[1]
data[ 'busFaxPlusFour' ]	= business.fax_number.split("-")[2]
data[ 'paymentTypes' ] = [ :AmericanExpress, :DebitCard, :MasterCard ]


data[ 'languagesSpoken' ] = [ :English, :Spanish ]
data[ 'yearEstablished' ] = business.year_founded
data[ 'industry' ] = 'Pets ->'
data[ 'category' ] = 'Aquarium Maintenance & Design'
data
