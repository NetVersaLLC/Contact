@browser.goto('http://www.cornerstonesworld.com/en/directory/country/USA')
@browser.text_field( :name => 'kw').set data['business']
@browser.link(:text => 'Detailed search').click

@browser.text_field(:name => 'zip').when_present.set data['zip']
@browser.button(:name => 'sbm').click
sleep(5)
Watir::Wait.until { @browser.table( :class => 'dirlist').exists? or @browser.text.include? "We didn't find any Corporate Profiles matching your query criteria."}
if @browser.text.include? "We didn't find any Corporate Profiles matching your query criteria."
  businessFound = [:unlisted]
else
  if @browser.span(:class => 'titlesmalldblue', :text => /#{data['business']}/).exists?
    
    businessFound = [:listed, :unclaimed]       
  else
    businessFound = [:unlisted]
  end 
end


[true,businessFound]