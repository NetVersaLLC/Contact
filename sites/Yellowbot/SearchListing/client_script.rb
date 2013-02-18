@browser.goto( "http://www.yellowbot.com/" )
sleep(5)
@browser.text_field( :id => 'search-field' ).set data[ 'phone' ]
@browser.button( :value => 'Find my business' ).click #, :type => 'submit'

sleep(5)
businessFound = []
found = false



begin

  @browser.link( :text => 'submit a new business').exists?

  businessFound = [:unlisted]

rescue Timeout::Error

businessFound = true
end

if businessFound == true

@browser.link( :text => '(view listing)').click

  begin
    @browser.link( :class => 'claim-business').exists?
    businessFound = [:listed, :unclaimed]
  rescue Timeout::Error
  businessFound = [:listed, :claimed]  
  end
end

puts(businessFound.to_s)
return true, businessFound