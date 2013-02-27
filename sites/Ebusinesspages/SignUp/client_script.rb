@browser.goto( 'http://ebusinesspages.com/' )
@browser.text_field( :name => 'co').set data['business']
@browser.text_field( :name => 'loc').set data['citystate']

@browser.link( :id => 'SearchMag').click
Watir::Wait.until { @browser.div( :class=> 'SearchResults' ).exists? }

if @browser.text.include? "No results found, please try again with less specific terms."
  
  businessFound = [:unlisted]
else

if @browser.link( :text => data['business']).exists?
@browser.link( :text => data['business']).click
Watir::Wait.until { @browser.div( :id=> 'ShowCompany' ).exists? }
  if @browser.link( :id => 'bVerifyButton').exists?
 
      businessFound = [:listed, :unclaimed]
    else
      businessFound = [:listed, :claimed]
    end  
  
  else
    businessFound = [:unlisted]
  end
end
