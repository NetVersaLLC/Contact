class EmailsController < ApplicationController
  before_filter      :authenticate_user!
  skip_before_filter :verify_authenticity_token
  def check
    klass    = Provider.get(params[:site])
    business = Business.find(params[:business_id])
    user     = current_user
    CheckMail.get_link(business) do |mail|
      if klass.my_mail(mail)
        @link = klass.get_link(mail)
      end
    end
  end
end
