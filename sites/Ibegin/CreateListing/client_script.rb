sign_in

@browser.goto('http://www.ibegin.com/business-center/submit/')
@browser.text_field( :name, 'name').set data['business_name']
@browser.text_field( :id, 'country').set data['country']
@browser.text_field( :id, 'region').set data['state_name']
@browser.text_field( :id, 'city').set data['city']
@browser.text_field( :name, 'address').set data['address']
@browser.text_field( :name, 'zip').set data['zip']
@browser.text_field( :name, 'phone').set data['phone']
@browser.text_field( :name, 'fax').set data['fax']
@browser.text_field( :name, 'category1').set data['category1']
@browser.text_field( :name, 'category2').set data['category2']
@browser.text_field( :name, 'category3').set data['category3']

@browser.text_field( :name, 'url').set data['url']
@browser.text_field( :name, 'facebook').set data['facebook']
@browser.text_field( :name, 'twitter_name').set data['twitter_name']
@browser.text_field( :name, 'desc').set data['desc']
@browser.text_field( :name, 'brands').set data['brands']
@browser.text_field( :name, 'products').set data['products']
@browser.text_field( :name, 'services').set data['services']


