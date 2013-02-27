@browser.goto("http://www.shopcity.com/map/mapnav_locations.cfm?")

@browser.link( :text => /#{data['country']}/).click
@browser.link( :text => /#{data['state']}/).when_present.click
@browser.link( :text => /#{data['citystate']}/).when_present.click	

@browser.text_field( :name => 'q').when_present.set data['business']
@browser.button( :src => '/style/1002/searchbutton.png').click
Watir::Wait.until { @browser.table(:id => 'search_results_pod_tag').exists? }
businessFound = []
if @browser.link( :text => /#{data['business']}/).exists?
sleep(3)
  @browser.link( :text => /#{data['business']}/).when_present.click
Watir::Wait.until { @browser.table(:id => 'toppod').exists? }
    
  if @browser.link(:xpath => '//*[@id="toppod"]/tbody/tr[2]/td[2]/div/div[1]/div/a').exists?
    businessFound = [:listed,:unclaimed]
  else
    businessFound = [:listed,:claimed]  
  end
else
    businessFound = [:unlisted]
end

[true, businessFound]