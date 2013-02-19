@browser.goto('http://www.yellowee.com')

@browser.text_field( :id => 'what').set data['business']
@browser.text_field( :id => 'where').set data['citystate']

@browser.button( :id => 'submit').click
sleep(5)

if @browser.text.include? "Sorry, we didn't find any results for"
  
  businessFound = [:unlisted]
else
 begin
    @browser.link( :title => /#{data['business']}/).exists?

    @browser.link( :title => /#{data['business']}/).click
    sleep(8)
 
 rescue Timeout::Error
    businessFound = [:unlisted]
 end  
  begin
    @browser.link( :title => 'Claim Business').exists?
     businessFound = [:listed, :unclaimed]
  rescue Timeout::Error
     businessFound = [:listed, :claimed]
  end  
  
end

puts(businessFound)
return true, businessFound