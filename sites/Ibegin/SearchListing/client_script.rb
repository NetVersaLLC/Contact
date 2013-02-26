@browser.goto('http://www.ibegin.com/')

@browser.text_field( :name => 'q').set data['query']

@browser.button( :xpath => '//*[@id="column2top"]/form[1]/p/label/input').click
sleep(5)

@frame = @browser.frame( :name => 'googleSearchFrame')

puts(@frame.div(:class => "gs-snippet").text)

if @frame.div(:class => "gs-snippet").text == "No Results"
  
  businessFound = [:unlisted]
else
  if @frame.link( :text => /#{data['business']} in #{data['city']}/).exists?  
        Alink = @frame.link( :text => /#{data['business']} in #{data['city']}/i )
        Alink.click
    sleep(8)
      
  else
    businessFound = [:unlisted]
  end  
  
  if @browser.li(:id => 'axNavClaimit').exists?        
        businessFound = [:listed, :unclaimed]
    
     else
        businessFound = [:listed, :claimed]
      
      end

end
[true, businessFound]