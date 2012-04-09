class MapQuest
    include HTTParty
    format :json
    base_uri "http://cite.netversa.com"
    debug_output

    def self.notify_of_join(key)
        get("/mapquests/check_email.json?auth_token=#{key}")
    end
end

browser = Watir::Browser.start("https://listings.mapquest.com/apps/listing")
browser.text_field(:name => "firstName").set business['first_name']
browser.text_field(:name => "lastName").set business['last_name']
browser.text_field(:name => "phone").set business['phone']
browser.text_field(:name => "email").set business['email']
browser.a(:class => 'btn-var submit').click
Watir::Wait::until do
    browser.text.include? "Confirmation email sent to"
end
