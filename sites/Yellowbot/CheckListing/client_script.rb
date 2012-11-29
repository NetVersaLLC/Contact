@browser.goto( "http://www.yellowbot.com/" )
@browser.text_field( :id => 'search-field' ).set data[ 'phone' ]
@browser.button( :value => 'Find my business' ).click #, :type => 'submit'

def submit_link; @browser.link( :text => 'submit a new business') end
def claim_link; @browser.link( :text => 'Claim' ) end

Watir::Wait::until do
  submit_link.exists? or claim_link.exists?
end

if submit_link.exists?

	puts("No business, adding now")
	if @chained
	  self.start("Yellowbot/CreateListing")
	end
# Claim existing business
elsif claim_link.exists?

	puts("Business exists, claiming")
	if @chained
	  self.start("Yellowbot/ClaimListing")
	end
	true
else
 throw( "Problem with locating link to continue YellowBot registration!" )
end
