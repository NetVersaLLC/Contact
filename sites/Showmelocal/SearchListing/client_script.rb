@browser.goto('http://www.showmelocal.com/')

@browser.text_field( :id => '_ctl5__ctl0_txtWhat').set data['business']
@browser.text_field( :name => '_ctl5:_ctl0:txtWhere').set data['citystate']

@browser.button( :name => '_ctl5:_ctl0:cmdSearch').click
sleep(5)

if @browser.link( :text => data['business']).exists?
    @browser.link( :text => /#{data['business']}/).click
        sleep(5)
      if @browser.link( :id => '_ctl5_hlAreYourTheOwner').exists?          
          businessFound = [:listed,:unclaimed]
      else
          businessFound = [:listed,:claimed]
      end
 
 else
    businessFound = [:unlisted]
 end  
 
 
[true, businessFound]