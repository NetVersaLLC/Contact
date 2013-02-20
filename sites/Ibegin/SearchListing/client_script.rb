@browser.goto('http://www.ibegin.com/')

@browser.text_field( :name => 'q').set data['query']

@browser.button( :xpath => '//*[@id="column2top"]/form[1]/p/label/input').click
sleep(5)

@frame = @browser.frame( :name => 'googleSearchFrame')

puts(@frame.div(:class => "gs-snippet").text)

if @frame.div(:class => "gs-snippet").text == "No Results"
  
  businessFound = [:unlisted]
else
  begin
        @frame.link( :text => /#{data['business']} in #{data['city']}/).exists?  
        Alink = @frame.link( :text => /#{data['business']} in #{data['city']}/i )
        Alink.click
    sleep(8)
      
  rescue Timeout::Error
    businessFound = [:unlisted]
  end  
  
  begin
        @browser.li(:id => 'axNavClaimit').exists?        
        businessFound = [:listed, :unclaimed]
    
      rescue Timeout::Error
        businessFound = [:listed, :claimed]
      
      end
  
  
    
end

return true, businessFound