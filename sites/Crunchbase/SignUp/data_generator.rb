data = {}
data['name'] 		= business.contact_first_name + ' ' + business.contact_last_name
data['username'] 	= business.bings.first.email.split("@")[0]
data['email'] 		= business.bings.first.email
data['password'] 	= Yahoo.make_password
data['twitter'] 	= 'happygolucky'#business.twitters.first.username
data['homepage'] 	= business.company_website
data['use_facebook'] 	= false
data
