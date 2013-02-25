@browser.goto('http://www.justclicklocal.com/')
@browser.text_field( :name => 'query').set data['business']
@browser.text_field( :name => 'location').set data['citystate']
@browser.button(:id => 'submit').click

sleep(10)

puts(@browser.link( :text => /#{data['business']}/).exists?.to_s)
puts(@browser.link( :text => /#{data['business']}/).html)

  if @browser.link( :text => /#{data['business']}/).exists?
     businessFound = [:listed, :unclaimed]
  else
     businessFound = [:unlisted] 
  end
[true, businessFound]