data = {}
data['phone_area_code']		= business.local_phone.split("-")[0]
data['phone_prefix']		= business.local_phone.split("-")[1]
data['phone_number']		= business.local_phone.split("-")[2]
data['name']			= business.business_name
data['address']			= business.address
data['address2']		= business.address2
data['fax_area_code']		= business.fax_number.split("-")[0]
data['fax_prefix']		= business.fax_number.split("-")[1]
data['fax_number']		= business.fax_number.split("-")[2]
data['city']			= business.city
data['state_long']		= business.state_name
data['zip']			= business.zip
data['first_name']		= business.contact_first_name
data['last_name']		= business.contact_last_name
data['email']			= 'netversatest81@gmail.com'#business.yahoos.first.email
data['description']		= business.business_description
data['ezlocal_category1']	= 'Restaurant' #business.category1
data['ezlocal_category2']	= '3D Designs' #business.category2
data['ezlocal_category3']	= '3D Signs' #business.category3
data['website']			= business.company_website
data