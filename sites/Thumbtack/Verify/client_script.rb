link = data['link']
puts("Here is the link")
puts(link)
@browser.goto(link)
Watir::Wait::until do
  browser.text.include? "Log Out"
end

if browser.text.include? "Log In/Join" 
  @job.failure("Uknown error")
	  throw "Unknown added page"
else
    @job.success("This was added")
if @chained
  self.start("Thumbtack/CreateListing")
end
    

end

