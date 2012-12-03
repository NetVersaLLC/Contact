  #Open Verification link & attach it to watir.
  @browser = Watir::Browser.attach(:title,/Create a password/)



if (@browser.text.include? 'Connect your Facebook account')
	@browser.link(:text, 'Skip this step').click
end
if (@browser.text.include? 'Add pictures to your listing')
	@browser.link(:text, 'Skip this step').click
end

  #Set Password
  @browser.text_field(:name => 'usr_password').set data['password']
  @browser.text_field(:name => 'usr_password_again').set data['password']
  @browser.link(:text, /Save/).click
  @browser.link(:text, /Continue/).click

if (@browser.text.include? 'Promote your listing')
	@browser.link(:text, /Continue/).click
end

@browser.link(:text, 'Skip this step').click
  #Answer questions related to services
#  @browser.text_field(:name => 'answer_9').when_present.set data['common_jobs']
#  @browser.text_field(:name => 'answer_23').set data['recent_jobs']
#  @browser.text_field(:name => 'answer_7').set data['advice_to_customer']
#  @browser.link(:text, /Save/).click
@browser.link(:text, 'Skip this step').click
#@browser.text_field(:name => 'recipients').when_present.set data['recipients']
@browser.link(:text, 'Skip this step').click
#@browser.link(:text, /Send/).click
#  @browser.text_field(:name => 'recipients').when_present.set data['recipients']
  @browser.link(:text, /Save/).when_present.click
  @browser.link(:text, /Continue/).when_present.click

  if @browser.div(:class => 'pod-content').h2.text == "#{data[ 'business' ]}"
    puts "Business Registered Succesfully"
  else
    throw("Business Registration Failed")
  end
