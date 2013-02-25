@browser.goto("http://www.shopcity.com/map/mapnav_locations.cfm?")

@browser.link( :text => /#{data['country']}/).click
@browser.link( :text => /#{data['state']}/).when_present.click
@browser.link( :text => /#{data['citystate']}/).when_present.click	


@browser.text_field( :name => 'q').when_present.set data['business']
@browser.button( :src => '/style/1002/searchbutton.png').click

sleep(5)
businessFound = []
if @browser.link( :text => /#{data['business']}/).exists?
sleep(5)
  @browser.link( :text => /#{data['business']}/).when_present.click

  sleep(5)
  
  if @browser.text.include? "Is This Your Business? Click Here to Claim Your Profile"
    businessFound = [:listed,:unclaimed]
  else
    businessFound = [:listed,:claimed]  
  end
else
    businessFound = [:unlisted]
end

[true, businessFound]