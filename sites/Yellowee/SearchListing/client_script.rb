@browser.goto('http://www.yellowee.com')

@browser.text_field( :id => 'what').set data['business']
@browser.text_field( :id => 'where').set data['citystate']

@browser.button( :id => 'submit').click
sleep(5)

if @browser.text.include? "Sorry, we didn't find any results for"
  
  businessFound = [:unlisted]
else
if @browser.link( :title => /#{data['business']}/).exists?

    @browser.link( :title => /#{data['business']}/).click
    sleep(8)
 
 else
    businessFound = [:unlisted]
 end  
  if @browser.link( :title => 'Claim Business').exists?
     businessFound = [:listed, :unclaimed]
  else
     businessFound = [:listed, :claimed]
  end  
  
end


[true, businessFound]