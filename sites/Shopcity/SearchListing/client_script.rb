@browser.goto("http://www.shopcity.com/map/mapnav_locations.cfm?")

@browser.link( :text => /#{data['country']}/).click
@browser.link( :text => /#{data['state']}/).click
@browser.link( :text => /#{data['cityState']}/).click	

sleep(5)

@browser.text_field( :name => 'q').set data['business']
@browser.button( :src => '/style/1002/searchbutton.png').click

businessFound = []

begin
  @browser.link( :text => /#{data['business']}/).exists?
  @browser.link( :text => /#{data['business']}/).click

  sleep(5)
  
  if @browser.text.include? "Is This Your Business? Click Here to Claim Your Profile"
    businessFound = [:listed,:unclaimed]
  else
    businessFound = [:listed,:claimed]  
  end
rescue Timeout::Error
    businessFound = [:unlisted]
end

return true, businessFound