@browser.goto( "https://biz.yelp.com/signup" )

@browser.text_field( :name => 'query').set data['business']
@browser.text_field( :name => 'location').set data['citystate']
@browser.button( :text => 'Search').click
sleep(5)
businessFound = []

begin
  @browser.h3( :text => data['business']).exists?
  puts("exsits!")
  
  begin 
  @browser.h3( :text => data['business']).parent.parent.li(:class => 'buttons-col').form(:name => 'select_business_form').button( :text => 'Unlock').exists?
    businessFound = [:listed, :unclaimed]
  rescue Timeout::Error
    businessFound = [:listed, :claimed]
  end
  
rescue Timeout::Error
  businessFound = [:unlisted]
end
puts(businessFound.to_s)
businessFound
