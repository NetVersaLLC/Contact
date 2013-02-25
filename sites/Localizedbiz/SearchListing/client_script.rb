@browser.goto('http://www.localizedbiz.com/')


@browser.text_field( :name => 'q').set data['business']
@browser.text_field( :name => 'loc').clear

@browser.button( :name => 'Submit').click
sleep(5)
if @browser.text.include? "no result found"
  businessFound = [:unlisted]
else
if @browser.link( :text => /#{data['business']}/).exists?
    businessFound = [:listed,:unclaimed]
 else
    businessFound = [:unlisted]
 end  

  
end

[true, businessFound]