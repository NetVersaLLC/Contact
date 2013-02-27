@browser.goto('http://www.yellowassistance.com/')
@browser.text_field( :name => 'txtBusCategory').set data['business']
@browser.text_field( :name => 'ddlBusState').set data['citystate']
@browser.button( :name => 'ibtnBusSearch').click
Watir::Wait.until { @browser.span(:id => 'lblTotalRecord').exists?}
businessFound = []
if @browser.div(:id => 'panExactMatch').exists?
  businessFound = [:unlisted]
else
  @browser.link( :text => data['business']).click  
  Watir::Wait.until { @browser.h1( :class => 'StaticTitle').exists? }
  @browser.link( :id => 'lnkListing').click
  Watir::Wait.until { @browser.div( :id => 'panAddUpdateListing').exists? }
  if @browser.text_field(:name => 'txtName').exists?
    businessFound = [:listed, :unclaimed]  
  else
    businessFound = [:listed, :claimed]  
  end 
end

[true, businessFound]