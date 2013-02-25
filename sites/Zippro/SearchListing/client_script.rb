@browser.goto('http://zip.pro/')


@browser.text_field( :name => 'q').when_present.set data['business']
@browser.text_field( :id => 'zp_l').set data['citystate']

@browser.button( :class => 'goBtn').click
sleep(5)

if @browser.text.include? "No Results Found!"

  businessFound = [:unlisted]
else

 if @browser.link( :text => data['business']).exists?
    @browser.link( :text => data['business']).click
    sleep(8)
 
 else
    businessFound = [:unlisted]
    
 end  
  if @browser.link( :id => 'a_prof_claim').exists?
  
     businessFound = [:listed, :unclaimed]
  else
     businessFound = [:listed, :claimed]
  end  
  
end

[true, businessFound]