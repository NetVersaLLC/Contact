def claim_it()
  @browser.div( :text , 'Claim' ).click
  begin
    captcha_text = solve_captcha()
    @browser.div( :class, 'LiveUI_Area_Picture_Password_Verification' ).text_field().set captcha_text
    @browser.div( :text , 'Continue' ).click
  end while @browser.html =~ /Characters did not match/

  Watir::Wait::until do
    @browser.div( :text, 'Ok' ).exists? # or  :class, 'Dialog_TitleContainer'
  end
  @browser.div( :text, 'Ok' ).click
  # Redirected to Business Portal - Details Page, so enter all the info as with new listing
end

sign_in( business )
search_for_business( business )
claim_it()
