@browser.goto('http://www.hyplo.com')

@browser.text_field( :id => 'search_term').set data['business']
@browser.text_field( :id => 'search_location').set data['zip']

@browser.button( :text => 'Search').click
sleep(5)

begin
@browser.div(:class => 'span12 foundsite').exists?
    begin
        @browser.link( :text => /#{data['business']}/).exists?
        businessFound = [:listed,:claimed]
    rescue Timeout::Error
         businessFound = [:unlisted]
    end
rescue Timeout::Error
  businessFound = [:unlisted]
end
 
return true, businessFound