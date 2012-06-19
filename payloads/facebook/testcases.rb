

require '2_email_verification'


business = {}
business['first_name'] = %w{April Jesse Danny Philli Beth Roth Case Ben Kassi Izzy}[rand(10)]
business['last_name'] = %w{Lopez Rodrigez Gamje Clark Strum Charles Hotek Lumpp Davis Robokof}[rand(10)]
business['email'] = "MyEmailILike@myworld.gov"
business['password'] = business['email'][0..-5]
business['gender'] = %w{Male Female}[rand(2)]
business['birth_month'] = %w{Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec}[rand(12)]
business['birth_day'] = rand(27) + 1
business['birth_year'] = 1993 - rand(30)

business['verifyCode'] = ev_rCfromFile( "fb_email.txt" )
business['verifyUrl'] = ev_sCodeUrl( business['verifyCode'], business['email'] )


registrar = File.open( "email-" + business['password'] + ".txt", "w" ) do |registrar|
	business.keys.each { |x| registrar << x + " = " + business[x].to_s + "\n"}
end

print "Now look at file " + "email-" + business['password'] + ".txt\n" 
