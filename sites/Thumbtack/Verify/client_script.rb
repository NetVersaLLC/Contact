link = data['link']
puts("Here is the link")
puts(link)
@browser.goto(link)



if @chained
  self.start("Thumbtack/CreateListing")
end
    


