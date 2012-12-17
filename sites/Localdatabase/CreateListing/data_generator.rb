data = {}
data['username']	 = business.localdatabases.first.username
data['password']	 = business.localdatabases.first.password
data['remember']	 = true
data['name'] 		 = business.business_name
data['address'] 	 = business.address + ' ' + business.address2
data['state'] 		 = business.state_name
data['city']		 = business.city
data['zipcode']		 = business.zip
data['phone']		 = business.local_phone
data['fax']		 = business.fax_number
data['website']		 = business.company_website
data['description']	 = business.business_description
data['category']	 = 'Aircraft'
data['subcategories'] 	 = 'Painting- Service- & Repair,Parts & Equipment Retail'
data['mtype']		 = '3'
data
