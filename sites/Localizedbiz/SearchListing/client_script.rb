@browser.goto('http://www.localizedbiz.com/')

@browser.text_field( :name => 'q').set data['business']
@browser.text_field( :name => 'loc').clear

@browser.button( :name => 'Submit').click
sleep(5)
if @browser.text.include? "no result found"
  
  businessFound = [:unlisted]
else
 begin
    @browser.link( :title => /#{data['business']}/).exists?
    businessFound = [:listed,:unclaimed]

 
 rescue Timeout::Error
    businessFound = [:unlisted]
 end  

  
end

puts(businessFound)
return true, businessFound