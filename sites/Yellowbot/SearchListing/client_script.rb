@browser.goto( "http://www.yellowbot.com/" )
sleep(5)
@browser.text_field( :id => 'search-field' ).set data[ 'phone' ]
@browser.button( :value => 'Find my business' ).click #, :type => 'submit'

sleep(5)
businessFound = []
found = false

puts("1")


begin
puts("2")
  @browser.link( :text => 'submit a new business').exists?
  puts("3")
  businessFound = [:unlisted]
  puts("4")
rescue Timeout::Error
puts("5")
businessFound = true
end

if businessFound == true
puts("6")
@browser.link( :text => '(view listing)').click
puts("7")
  begin
    @browser.link( :class => 'claim-business').exists?
    businessFound = [:listed, :unclaimed]
  rescue Timeout::Error
  businessFound = [:listed, :claimed]  
  end
end

puts(businessFound.to_s)
 businessFound