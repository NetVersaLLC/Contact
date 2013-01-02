#puts(data['url'])
@browser.goto(data['url'])

if @browser.text.include? "To activate registration please enter your password."
	@browser.text_field( :id => 'txtPassword').set data['password']
	@browser.button( :id => 'cmdActivate').click

end

