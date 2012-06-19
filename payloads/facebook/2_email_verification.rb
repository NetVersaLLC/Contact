# In facebook email verification code lies in the link between this segment of code 'c.php?code=' and this '&amp;email='

# ev_returnCode : Dump entire raw e-mail from facebook in this function to extract the verification number
def ev_returnCode( getCode )
    if getCode.include? '&amp;email='
        open = "c.php?code="
        open = getCode.index( open ) + open.length 
        close = getCode.index( "&amp;email=", open )
        getCode = getCode[open...close]
	return getCode
    end
    return ""
end

# ev_rCfromFile ( FILE ) : Give this function the email in the form of a file to extract the verification code
def ev_rCfromFile( getFile )
	file = File.open( getFile )
	verificationCode =""
	file.each { |x| verificationCode = ev_returnCode(x) }
	return verificationCode
end

# ev_sCodeUrl ( CODE, E-Mail ) : This returns the proper url for verification on facebook CODE = verify code and E-Mail is the e-mail address
def ev_sCodeUrl( code, email )
	return "http://www.facebook.com/c.php?code=" + code + "&amp;email=" + email
end


# print returnCode("http://www.facebook.com/c.php?code=987450238472&amp;email=noexisty%40yahoo.com") + "\n" # Test Case
# print rCfromFile( "fb_email.txt" ) # Test Case
