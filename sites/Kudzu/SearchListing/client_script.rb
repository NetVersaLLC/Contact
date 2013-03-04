@browser.goto('http://www.kudzu.com/')

@browser.text_field( :id => 'searchterms').set data['business']
@browser.text_field( :id => 'currentLocation').set data['zip']
@browser.button( :name => 'submit').click
sleep(10)

if @browser.text.include? "We're sorry, no results were found for"
  businessFound = [:unlisted]
else
  begin
      @browser.link( :name => 'name', :text => /#{data['business']}/).exists?
      @browser.link( :name => 'name', :text => /#{data['business']}/).click
      
      Watir::Wait.until { @browser.span( :text => 'Overview').exists? }
      
      if @browser.span( :text => 'Claim This Profile!').exists?
          businessFound = [:listed,:unclaimed]
      else
          businessFound = [:listed,:claimed]
      end
  
  rescue Timeout::Error
    businessFound = [:listed,:claimed]
  
  end


end

=begin
url = "http://www.kudzu.com/controller.jsp?N=0&searchVal=#{data['businessfixed']}&currentLocation=#{data['zip']}&searchType=keyword&Ns=P_PremiumPlacement"
puts(url)
page = Nokogiri::HTML(RestClient.get(url))  
firstItem = page.css("div.navRecordDiv")

if firstItem.length == 0
  businessFound = [:unlisted]
else
  theLink = firstItem.css("//table/tbody/tr/td[2]/div[1]/a")
  puts(theLink['href'])
  
  
end

=end


[true, businessFound]