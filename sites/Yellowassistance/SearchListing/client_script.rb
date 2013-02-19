@browser.goto('http://www.yellowassistance.com/')

@browser.text_field( :name => 'txtBusCategory').set data['business']
@browser.text_field( :name => 'ddlBusState').set data['citystate']

@browser.button( :name => 'ibtnBusSearch').click
sleep(5)

businessFound = []

if @browser.text.include? "We did not find an exact match for your search."
  businessFound = [:unlisted]
else
  @browser.link( :text => data['business']).click
  
  sleep(5)
  @browser.link( :id => 'lnkListing').click
  sleep(5)
  
  if @browser.text.include? "Step 1 - Provide your Contact Information"
    businessFound = [:listed, :unclaimed]
  
  else
    businessFound = [:listed, :claimed]
  
  end
  

end

puts(businessFound)
return true, businessFound