@browser.goto( 'http://www.digabusiness.com' )

@browser.text_field( :name => 'search').set data['business']
@browser.send_keys :enter
sleep(10)

begin
    @browser.link( :title => data['business']).exists?
     businessFound = [:listed, :unclaimed]
  rescue Timeout::Error
     businessFound = [:unlisted]
  end  
  
  
  puts(businessFound)
return true, businessFound


