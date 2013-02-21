@url = 'http://www.getfave.com/'
@browser.goto(@url)

@browser.link(:id,'change-location').flash
@browser.link(:id,'change-location').when_present.click
@browser.text_field(:id, 'g-text-field').set data[ 'citystate' ]
@browser.button(:value,'Pin').click
#@browser.button(:value,'Pin').click
@browser.goto("http://www.getfave.com/search?utf8=?&q=" + data[ 'bus_name_fixed' ])
#Watir::Wait.until { @browser.div(:id,'results').exists? }
sleep(5)
@results = @browser.div(:id,'results') 
@result_msg = "We couldn't find any matches."
@matching_result = @browser.div(:id,'business-results').span(:text,"#{data[ 'business' ] }")


if @browser.text.include?(@result_msg)
businessFound = [:unlisted]

else

    if @matching_result.text =~ /#{data['business']}/
        @matching_result.click
        
        begin
            if @browser.link( :text => 'Manage this Business').exists?
                businessFound = [:listed, :unclaimed]
            else
                businessFound = [:listed, :claimed]
            end
        rescue Timeout::Error
        
        end
        
        
    else
        businessFound = [:unlisted]
    end


end

return true, businessFound