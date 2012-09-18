link = data['link']

browser = Watir::Browser.start(link)
Watir::Wait::until do
  browser.text.include? "Your Business Has Been Added To Yelp"
end
if browser.text.include? "Your Business Is Almost On Yelp"
  ContactJob.success("This was added")
else
  ContactJob.failure("Uknown error")
  throw "Unknown added page"
end
