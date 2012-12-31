data = {}
data[ 'username' ]		= business.localizedbizs.first.username[0..14]
data[ 'password' ]		= business.localizedbizs.first.password#xqPe2Sg82LuTHbk
data[ 'category1' ]		= "Internet Services"#business.category1
data[ 'category2' ]		= "Web Design"#business.category2
data[ 'state' ]			= business.state_name
data[ 'city' ]			= business.city
data[ 'business' ]		= business.business_name
data[ 'address' ]		= business.address + "  " + business.address2
data[ 'address2' ]		= business.address2
data[ 'zip' ]			= business.zip
data[ 'phone' ]			= business.local_phone
data[ 'areacode' ]		= business.local_phone.split("-")[0]
data[ 'exchange' ]		= business.local_phone.split("-")[1]
data[ 'last4' ]			= business.local_phone.split("-")[2]
data[ 'fax' ]			= business.fax_number
data[ 'email' ]			= business.bings.first.email
data[ 'website' ]		= business.company_website.gsub("http://", "")
data[ 'hours' ]			= Getfav.consolidate_hours( business )
data[ 'description' ]		= business.business_description
data[ 'keywords' ]		= business.keyword1 + ", " + business.keyword2 + ", " + business.keyword3 + ", " + business.keyword4 + ", " + business.keyword5
data[ 'tagline' ]		= business.category1 + " " + business.category2 + " " + business.category3
data[ 'image' ]			= "C:\\1.jpg"
data



