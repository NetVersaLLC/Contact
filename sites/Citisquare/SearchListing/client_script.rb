@browser.goto('http://my.citysquares.com/search')


@browser.text_field( :name => 'b_standardname').set data['business']
@browser.text_field( :name => 'b_zip').set data['zip']
@browser.button( :id => 'edit-b-search').click

sleep(5)
businessFound = []
 begin
 @browser.link( :text => data['business']).exists?
 sleep(5)
 
      begin
          @browser.link( :text => data['business']).parent.parent.link( :id => 'claimButton').exists?
           businessFound = [:listed,:unclaimed]
      rescue Timeout::Error
          businessFound = [:listed,:claimed]
      end
     
     
  rescue Timeout::Error
     businessFound = [:unlisted]
  end 

  return true, businessFound

