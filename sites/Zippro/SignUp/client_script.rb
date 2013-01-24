@browser.goto( "http://myaccount.zip.pro/find-business.php" )
@browser.text_field( :id => 'bzPhone').set data['phone']

@browser.button( :id => 'search_find_tel').click

@browser.link( :class => 'createList').click

@browser.text_field( :id => 'comp_name').set data[ 'business' ]
@browser.text_field( :id => 'address').set data[ 'address' ]
@browser.text_field( :id => 'addressln2').set data[ 'address2' ]
@browser.text_field( :id => 'city').set data[ 'city' ]
@browser.select_list( :id => 'zp_state_selection').select data[ 'state_name' ]
@browser.text_field( :id => 'zip').set data[ 'zip' ]
@browser.text_field( :id => 'main_phone').set data[ 'phone' ]
@browser.text_field( :id => 'comp_name').set data[ 'business' ]

@browser.link( :id => 'zpPriCatPop').click
sleep(2)
@browser.link( :id => 'catTree_30162').click
@browser.link( :id => 'zpCatMoveRight').click
@browser.button( :id => 'zpSaveCategory').click

@browser.link( :id => 'zpSecCatPop').click
sleep(2)
@browser.link( :id => 'catTree_30165').click
@browser.link( :id => 'zpCatMoveRight').click
@browser.button( :id => 'zpSaveCategory').click

enter_captcha( data )

@browser.text_field( :id => 'f_name').set data['fname']
@browser.text_field( :id => 'l_name').set data['lname']
@browser.text_field( :id => 'email').set data['email']
@browser.text_field( :id => 'v_email').set data['email']
@browser.text_field( :id => 'password').set data['password']
@browser.text_field( :id => 'c_password').set data['password']

@browser.text_field( :id => 'answer').set data[ 'secretAnswer' ]

enter_captcha2( data )

if @browser.text.include? "Verify your email address"
	RestClient.post "#{@host}/accounts.json?auth_token=#{@key}&business_id=#{@bid}", 'account[username]' => data['email'], 'account[password]' => data['password'], 'account[secret1]' => data['secretAnswer'], 'model' => 'Zippro'
	if @chained
		self.start("Zippro/Verify")
	end
	
	true
end