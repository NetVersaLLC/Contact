@browser.goto('http://www.merchantcircle.com')

@browser.text_field( :id => 'q').set data['business']
@browser.text_field( :id => 'qn_search').set data['citystate']
@browser.button( :id => 'searchBtnHead').click
sleep(10)


@resultList = @browser.div( :id => 'searchResultsWithPreferred')
begin
  if @resultList.h3(:class => 'listName').span( :text => /#{data['business']}/).exists? 
      @resultList.h3(:class => 'listName').span( :text => /#{data['business']}/).click      
      sleep(5)
      
      begin
        if @browser.link(:text => 'Claim Your Business').exists?      
          businessFound = [:listed, :unclaimed]
          
        else
        
          businessFound = [:listed, :claimed]
        end      
      rescue Timeout::Error
      
         businessFound = [:listed, :claimed]
      end
  
  
  
  else
  
      businessFound = [:unlisted]
  end
  
rescue Timeout::Error

  businessFound = [:unlisted]
end

return true, businessFound