@browser.goto('http://www.kudzu.com/')

@browser.text_field( :id => 'searchterms').set data['business']
@browser.text_field( :id => 'currentLocation').set data['zip']
@browser.button( :name => 'submit').click
sleep(10)

if @browser.text.include? "We're sorry, no results were found for"
  businessFound = [:unlisted]
else
  begin
      @browser.link( :name => 'name', :text => /#{data['business']}/).exists?
      @browser.link( :name => 'name', :text => /#{data['business']}/).click
      
      if @browser.span( :text => 'Claim This Profile!').exists?
          businessFound = [:listed,:unclaimed]
      else
          businessFound = [:listed,:claimed]
      end
  
  rescue Timeout::Error
    businessFound = [:listed,:claimed]
  
  end


end

puts(businessFound)
return true, businessFound