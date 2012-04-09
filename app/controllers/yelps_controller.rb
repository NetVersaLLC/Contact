class YelpsController < ApplicationController
  before_filter :authenticate_user!

  def check_email
    business = Business.find_by_user_id(current_user.id)
    CheckMail.new(business) do |mail|
      if mail.subject =~ /Verify Your Email Address/
        if mail.body =~ /(https:\/\/biz.yelp.com\/signup\/confirm\/\S+)/
          link = $1
          Job.create do |j|
            j.user_id = current_user.id
            j.status = 0
            j.payload = <<RUBY
RUBY
            j.wait = false
          end
        end
      end
    end
    @status = { :status => :wait }
    respond_to do |format|
      format.json { render json: @status }
    end
  end
end
