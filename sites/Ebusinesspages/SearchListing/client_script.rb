@browser.goto('http://ebusinesspages.com/')

@browser.text_field( :name => 'co').set data['business']
@browser.text_field( :name => 'loc').set data['citystate']

@browser.link( :id => 'SearchMag').click
sleep(5)

if @browser.text.include? "No results found, please try again with less specific terms."
  
  businessFound = [:unlisted]
else
 begin
 @browser.link( :text => data['business']).click
 sleep(5)
    @browser.link( :id => 'bVerifyButton').exists?
     businessFound = [:listed, :unclaimed]
  rescue Timeout::Error
     businessFound = [:listed, :claimed]
  end  
  
end

return true, businessFound