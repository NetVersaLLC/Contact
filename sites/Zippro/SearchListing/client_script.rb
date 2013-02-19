@browser.goto('http://zip.pro/business-owners.php')

@browser.text_field( :name => 'q').set data['business']
@browser.text_field( :id => 'zp_l').set data['citystate']

@browser.button( :id => 'btngo').click
sleep(5)

if @browser.text.include? "No Results Found!"
  
  businessFound = [:unlisted]
else
 begin
    @browser.link( :text => data['business']).exists?
    @browser.link( :text => data['business']).click
    sleep(8)
 
 rescue Timeout::Error
    businessFound = [:unlisted]
 end  
  begin
    @browser.link( :id => 'a_prof_claim').exists?
     businessFound = [:listed, :unclaimed]
  rescue Timeout::Error
     businessFound = [:listed, :claimed]
  end  
  
end

return true, businessFound