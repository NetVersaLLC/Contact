@browser.goto( 'http://www.showmelocal.com/businessregistration.aspx' )

#business info
@browser.text_field( :id => 'txtBusinessName').set data[ 'business' ]
@browser.select_list( :id => '_ctl7_cboCategory').select data[ 'category' ]
@browser.text_field( :id => 'txtType').set data[ 'type' ]
@browser.text_field( :id => '_ctl4_txtPhone1').set data[ 'phone' ]
@browser.text_field( :id => '_ctl3_txtAddress1').set data[ 'address' ]
@browser.text_field( :id => '_ctl3_txtAddress2').set data[ 'address2' ]
@browser.text_field( :id => '_ctl3_txtCity').set data[ 'city' ]
@browser.select_list( :id => '_ctl3_cboState').select data[ 'state' ]
@browser.text_field( :id => '_ctl3_txtZip').set data[ 'zip' ]

#personal info
@browser.text_field( :id => '_ctl2_txtFirstName').set data[ 'fname' ]
@browser.text_field( :id => '_ctl2_txtLastName').set data[ 'lname' ]
@browser.text_field( :id => '_ctl2_txtEmail').set data[ 'email' ]
@browser.text_field( :id => '_ctl2_txtEmailConfirm').set data[ 'email' ]
@browser.text_field( :id => '_ctl2_txtPassword').set data[ 'password' ]
@browser.text_field( :id => '_ctl2_txtPasswordsConfirmed').set data[ 'password' ]

@browser.checkbox( :id => 'chkAgree').click

puts(data['password'])

enter_captcha( data )

if @browser.text.include? 'Your account requires activation. Your Business Profile is HIDDEN until your account is ACTIVATED.'
RestClient.post "#{@host}/accounts.json?auth_token=#{@key}&business_id=#{@bid}", 'account[username]' => data['email'], 'account[password]' => data['password'], 'model' => 'Showmelocal'
	if @chained
		self.start("Showmelocal/Verify")
	end
end

