@browser.goto( 'http://www.digabusiness.com' )
@browser.text_field( :name => 'search').set data['business']
@browser.send_keys :enter
sleep(10)

if @browser.link( :title => data['business']).exists?
     businessFound = [:listed, :unclaimed]
else
     businessFound = [:unlisted]
end  
  

[true, businessFound]


