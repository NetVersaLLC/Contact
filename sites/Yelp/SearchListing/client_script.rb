@browser.goto( "https://biz.yelp.com/signup" )

@browser.text_field( :name => 'query').set data['business']
@browser.text_field( :name => 'location').set data['citystate']
@browser.button( :text => 'Search').click
Watir::Wait.until { @browser.text.include? "Business matches for" or @browser.link(:text => 'Sorry, there were no matches. Please try adjusting your search.').exists? }
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
