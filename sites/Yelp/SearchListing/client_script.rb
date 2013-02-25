@browser.goto( "https://biz.yelp.com/signup" )

@browser.text_field( :name => 'query').set data['business']
@browser.text_field( :name => 'location').set data['citystate']
@browser.button( :text => 'Search').click
sleep(5)
businessFound = []

if @browser.h3( :text => data['business']).exists?
  
  if @browser.h3( :text => data['business']).parent.parent.li(:class => 'buttons-col').form(:name => 'select_business_form').button( :text => 'Unlock').exists?
    businessFound = [:listed, :unclaimed]
  else
    businessFound = [:listed, :claimed]
  end
  
else
  businessFound = [:unlisted]
end


[true, businessFound]
