@browser.goto('http://www.localndex.com/claim/')
@browser.text_field( :id => 'ctl00_ContentPlaceHolder1_txtStartPhone1').set data['phone']
@browser.button(:id => 'ctl00_ContentPlaceHolder1_btnGetStarted1').click 
sleep(5)

if @browser.text.include? "We couldn't find your business with the information provided."

  businessFound = [:unlisted]

true
elsif @browser.text.include? "Welcome"

  @browser.button( :src => 'images/localndex_promo_advtoday.png').click

  sleep(5)
  
  thelink = @browser.link( :id => 'ctl00_ContentPlaceHolder1_lnkProfilePage2').attribute_value("href")
  @browser.goto(thelink)
  
    if @browser.link( :id => 'lnkBusLogo').exists?
        businessFound = [:listed, :unclaimed]
    else
        businessFound = [:listed, :claimed]
    end
        businessFound = [:listed, :claimed]
end



[true, businessFound]
