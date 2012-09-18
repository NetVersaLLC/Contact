data = {}
data['area_code'] = business.contact_phone.split("-")[0]
data['password'] = Yahoo.create_password
data['category_id'] = business.yelps.first.yelp_category_id
data
