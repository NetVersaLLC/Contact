@browser.goto('http://www.localpages.com/')

@browser.text_field( :id => 'keywords').set data['business']
@browser.text_field( :id => 'location').set data['citystate']
@browser.button( :xpath => '/html/body/div[2]/div/div[2]/div[3]/div[2]/form/input[5]').click
sleep(10)

list = @browser.ul( :class => "results_list", :index => 1)

if list.lis.size > 0

      if list.h3( :text => /#{data['business']}/).exists?       
        businessFound = [:listed,:claimed]
      else
        businessFound = [:unlisted]
      end
    
  
else
businessFound = [:unlisted]
end

[true, businessFound]
