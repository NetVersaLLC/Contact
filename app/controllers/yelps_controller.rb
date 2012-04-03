class YelpsController < ApplicationController
  before_filter :authenticate_user!

  def check_email
    business = Business.find_by_user_id(current_user.id)
    sleep 10
    Mail.defaults do
      retriever_method :imap, { :address => business.mail_host,
                                :port => business.mail_port,
                                :user_name => business.mail_username,
                                :password => business.mail_password,
                                :enable_ssl => true }
    end
    Mail.all.each do |mail|
      if mail.subject =~ /Verify Your Email Address/
        if mail.body =~ /(https:\/\/biz.yelp.com\/signup\/confirm\/\S+)/
          link = $1
          Job.create do |j|
            j.user_id = current_user.id
            j.status = 0
            j.payload = <<RUBY
class Yelp
    include HTTParty
    format :json
    base_uri "http://cite.netversa.com"
    # debug_output

    def self.notify_of_verify(key)
        get("/yelps/verified.json?auth_token=\#{key}")
    end
end

browser = Watir::Browser.start("#{link}")
Watir::Wait::until do
  browser.text.include? "Your Business Has Been Added To Yelp"
end
if browser.text.include? "Your Business Is Almost On Yelp"
  Yelp.notify_of_verify(key)
else
  puts "Wasnt added"
end
RUBY
            j.wait = false
          end
        end
      end
    end

    respond_to do |format|
      format.json { render json: {:status => :wait} }
    end
  end
end
