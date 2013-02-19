@browser.goto('http://webapp.localeze.com/directory/search.aspx')

@browser.text_field( :id => 'ctl00_ContentPlaceHolderMain_SearchControl_txtPhoneNumber').set data['phone']

@browser.button( :id => 'ctl00_ContentPlaceHolderMain_SearchControl_SearchByPhoneButton').click

sleep(5)


if @browser.text.include? "There were no listings that match what you searched for."
  businessFound = [:unlisted]
else
 begin
 @browser.link( :text => data['business']).click
 sleep(5)
    
    if @browser.text.include? "This business listing has already been claimed."
        businessFound = [:listed, :claimed]
    else    
        businessFound = [:listed, :unclaimed]
    end
     
     
  rescue Timeout::Error
     businessFound = [:unlisted]
  end  

end

return true, businessFound