begin

@browser.goto( "http://www.yellowbot.com/" )
@browser.text_field( :id => 'search-field' ).set data[ 'phone' ]
@browser.button( :value => 'Find my business' ).click #, :type => 'submit'

def submit_link; @browser.link( :text => 'submit a new business') end
def claim_link; @browser.link( :text => 'Claim' ) end

#TODO ADD PHONE VERIFICATION
#@browser.link( :text, 'Claim my business').click





rescue Exception => e
  puts("Exception Caught in Business Listing")
  puts(e)
end

