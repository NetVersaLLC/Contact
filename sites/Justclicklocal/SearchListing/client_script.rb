@browser.goto('http://www.justclicklocal.com/')

@browser.text_field( :name => 'query').set data['business']
@browser.text_field( :name => 'location').set data['citystate']
@browser.button(:id => 'submit').click

sleep(10)

  begin
    @browser.link( :text => data['business'], :class => 'link').exists?
     businessFound = [:listed, :unclaimed]
  rescue Timeout::Error
     businessFound = [:unlisted] 
  end

return true, businessFound