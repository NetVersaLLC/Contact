@browser.goto( 'http://www.expressbusinessdirectory.com/login.aspx' )
@browser.text_field( :id => 'ctl00_ContentPlaceHolder1_txtEmail').set data['email']
@browser.text_field( :id => 'ctl00_ContentPlaceHolder1_txtPassword').set data['password']

@browser.link( :id => 'ctl00_ContentPlaceHolder1_cmdLogin').click

@browser.link( :text => "#{data[ 'business' ]}").click

true