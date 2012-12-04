data = {}
seed = rand( 1000 ).to_s()
data[ 'first_name' ]        = 'John'#business.contact_first_name
data[ 'last_name' ]         = 'Smith'#business.contact_last_name
data[ 'phone' ]        	    = '8164535'+seed#business.local_phone
data[ 'email' ]		    = business.bings.first.email
data[ 'business' ]	    = 'The Business of '+seed#business.business_name
data[ 'website' ] 	    = business.company_website.gsub("http://", "")
data[ 'description' ] 	    = business.business_description
data[ 'title' ] 	    = business.keyword1 + ' ' + business.keyword2
data[ 'address' ] 	    = business.address + ' ' +business.address2 + '#47'
data[ 'city' ] 		    = business.city
data[ 'state' ] 	    = business.state_name
data[ 'zip' ] 	 	    = business.zip
data[ 'country' ]  	    = 'United States'
data[ 'image' ]  	    = business.logo_file_name
data

 
