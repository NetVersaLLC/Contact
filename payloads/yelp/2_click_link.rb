class Yelp
    include HTTParty
    format :json
    base_uri ContactJob.host
    # debug_output

    def self.notify_of_verify(key)
        get("/yelps/verified.json?auth_token=\#{key}")
    end
end

browser = Watir::Browser.start(link)
Watir::Wait::until do
  browser.text.include? "Your Business Has Been Added To Yelp"
end
if browser.text.include? "Your Business Is Almost On Yelp"
  Yelp.notify_of_verify(key)
else
  puts "Wasnt added"
end
