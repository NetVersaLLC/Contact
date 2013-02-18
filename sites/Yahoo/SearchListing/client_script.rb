
@browser.goto( 'http://www.yahoo.com/' )

@browser.span(:text => 'Local').click
sleep(5)
@browser.text_field( :title => 'Local Search').set data['business']
@browser.text_field( :name => 'csz').set data['citystate']

@browser.button( :id => 'search-submit').click
sleep(5)

businessFound = []

begin
@browser.link( :text => data['business']).exists?
businessFound = [:listed, :unclaimed]
rescue Timeout::Error
businessFound = [:unlisted]
end

return true, businessFound