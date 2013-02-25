@data[ 'citystate' ] = @data[ 'city' ] + ", " + @data[ 'state_short' ]
@browser.goto( 'http://local.yahoo.com/' )

@browser.text_field( :id => 'yls-p').when_present.focus
@browser.text_field( :id => 'yls-p').set @data['business']
@browser.text_field( :name => 'addr').set @data['citystate']

@browser.button( :xpath => '//*[@id="bd"]/form/fieldset/button').click

sleep(5)

businessFound = []
puts(data['business'])

if @browser.link( :text => /#{data['business']}/i).exists?
businessFound = [:listed, :unclaimed]
else
businessFound = [:unlisted]
end

return true, businessFound