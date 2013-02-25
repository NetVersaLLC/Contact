@browser.goto('https://www.matchpoint.com/')

@browser.text_field( :name => 'q').set data['business']
@browser.text_field( :id => 'g').set data['citystate']
@browser.button( :id => 'mpSearchTermSubmit').click
sleep(10)

begin
  if @browser.div(:class => 'mp-result isFree ').link(:text => /#{data['business']}/).exists?
    thelink = @browser.div(:class => 'mp-result isFree ').link(:text => /#{data['business']}/).attribute_value "href"
    @browser.goto(thelink)
    sleep(10)
    
    begin
      @browser.link(:text => 'Claim This Page »').exists?
      businessFound = [:listed, :unclaimed]
    rescue Timeout::Error
        businessFound = [:listed, :claimed]
    end
  
  else
    businessFound = [:unlisted]
  end
  
rescue Timeout::Error
  businessFound = [:unlisted]
end





puts(businessFound)
return true, businessFound