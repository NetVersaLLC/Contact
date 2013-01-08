@browser.goto('https://www.matchpoint.com/login.htm')

@browser.text_field( :name => 'email').set data['username']

@browser.execute_script("
			oFormObject = document.forms['login'];
			oFormObject.elements['password'].value = '#{data['password']}';
			")



@browser.button( :value => 'Log In').click

@browser.goto('www.matchpoint.com/addbusiness')

@browser.text_field( :id => 'companyName').set data['business']
@browser.text_field( :id => 'streetAddress').set data['address']
@browser.text_field( :id => 'suite').set data['address2']
@browser.text_field( :id => 'city').set data['city']
@browser.select_list( :id => 'state').select data['state']

@browser.execute_script("
			oFormObject = document.forms['addBusinessForm'];
			oFormObject.elements['zipCode'].value = '#{data['zip']}';
			oFormObject.elements['phone1'].value = '#{data['areacode']}';
			oFormObject.elements['phone2'].value = '#{data['exchange']}';
			oFormObject.elements['phone3'].value = '#{data['last4']}';
			")
			

@browser.text_field( :id => 'cat_text_temp').set data['category1']
sleep(2)
@browser.li( :id => 'as-result-item-0').click

@browser.button( :id => 'mpAddBusinessSubmit').click

if @browser.text.include? "Getting Started"
true
end

