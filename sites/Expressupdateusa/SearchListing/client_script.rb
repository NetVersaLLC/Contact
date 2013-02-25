url = "http://listings.expressupdateusa.com/Search/Results?CompanyNameFilter=&State=&PhoneNumberFilter="+data['phone'].gsub("-","")

@browser.goto(url)

if @browser.text.include? "No listings found."
  businessFound = [:unlisted]
else
  
  begin
      if @browser.link( :title => 'Verify this listing').exists?
          businessFound = [:listed, :unclaimed]
      else
          businessFound = [:listed, :claimed]
      end
  rescue Timeout::Error
          businessFound = [:listed, :claimed]  
  end
end

return true, businessFound