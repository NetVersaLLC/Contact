link = data['link']
@browser.goto(link)
Watir::Wait::until do
  @browser.text.include? "Log Out"
end

if @browser.text.include? "Log In/Join" 
    self.failure("Uknown error")
   throw "Unknown added page"
else
    self.success("This was added")
if @chained
  self.start("Getfave/CreateListing")
end

end

