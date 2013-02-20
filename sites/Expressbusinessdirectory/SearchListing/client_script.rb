@browser.goto('http://www.expressbusinessdirectory.com')

@browser.text_field( :name => 'ctl00$txtSearch').set data['business']


@browser.button( :name => 'ctl00$cmdSearch').click
sleep(5)


if @browser.text.include? "Sorry, no search results found."
  
  businessFound = [:unlisted]
else
 begin
    @browser.link( :text => /#{data['business']}/).exists?

    @browser.link( :text => /#{data['business']}/).click
    sleep(8)
 rescue Timeout::Error
    businessFound = [:unlisted]
 end  
  
    @browser.link( :id => 'ctl00_ContentPlaceHolder1_hypClaimBusiness').click
      sleep(5)

      if @browser.text.include? "Request permission to update a company"
          businessFound = [:listed, :claimed]
      else
          businessFound = [:listed, :unclaimed]
      end  
end

puts(businessFound)
return true, businessFound