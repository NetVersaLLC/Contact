link = data['link']

browser = Watir::Browser.goto(link)
Watir::Wait::until do
  browser.text.include? "Your Business Has Been Added To Yelp"
end
if browser.text.include? "Your Business Is Almost On Yelp"
  @job.success("This was added")
else
  @job.failure("Uknown error")
  throw "Unknown added page"
end
