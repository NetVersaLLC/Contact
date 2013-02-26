@browser.goto('http://www.yellowise.com/')

@browser.text_field(:id => 'l-what').set data['business']
@browser.text_field(:id => 'l-where').set data['citystate']
@browser.button(:class => 'form-submit').click

Watir::Wait.until { @browser.h2(:class => 'search-title').exists? }

if @browser.text.include? "No Business Results Found!"
  businessFound = [:unlisted]
else


@browser.divs(:class => 'search-item').each do |item|
  
    if item.link( :text => /#{data['business']}/).exists?
      item.link( :text => /#{data['business']}/).click
      Watir::Wait.until { @browser.h1(:class => 'bigger businessName').exists? }
      businessFound = [:unlisted]
      if @browser.span(:id => 'claimbuttonText').exists?
        businessFound = [:listed, :unclaimed]
        break
      else
        businessFound = [:listed, :claimed]
        break
      end
    end
  
  end
    
end
  
[true,businessFound]