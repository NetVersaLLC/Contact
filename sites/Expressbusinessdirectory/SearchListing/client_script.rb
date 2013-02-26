@browser.goto('http://www.expressbusinessdirectory.com')

@browser.text_field( :name => 'ctl00$txtSearch').set data['business']


@browser.button( :name => 'ctl00$cmdSearch').click
sleep(5)


if @browser.text.include? "Sorry, no search results found."
  
  businessFound = [:unlisted]
else
 if @browser.link( :text => /#{data['business']}/).exists?

    @browser.link( :text => /#{data['business']}/).click
    sleep(8)
    
    if @browser.link( :id => 'ctl00_ContentPlaceHolder1_hypClaimBusiness').exists?
      businessFound = [:listed, :unclaimed]
      
    else
      businessFound = [:listed, :claimed]    
    end  
    
 else
    businessFound = [:unlisted]
 end  
  
    
end

[true, businessFound]