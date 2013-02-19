@browser.goto('http://www.showmelocal.com/')

@browser.text_field( :id => '_ctl5__ctl0_txtWhat').set data['business']
@browser.text_field( :name => '_ctl5:_ctl0:txtWhere').set data['citystate']

@browser.button( :name => '_ctl5:_ctl0:cmdSearch').click
sleep(5)

begin
    @browser.link( :text => data['business']).exists?
    @browser.link( :text => /#{data['business']}/).click
      begin
          @browser.link( :id => '_ctl5_hlAreYourTheOwner').exists?          
          businessFound = [:listed,:unclaimed]
      rescue Timeout::Error
          businessFound = [:listed,:claimed]
      end
 
 rescue Timeout::Error
    businessFound = [:unlisted]
 end  
 
return true, businessFound