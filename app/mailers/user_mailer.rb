class UserMailer < ActionMailer::Base
  default from: "support@towncenter.com"

  def welcome_email(user)
    @user = user
    @url  = "https://#{user.label.domain}/users/sign_in"
    mail(:to => user.email, :from => user.label.mail_from, :subject => "Welcome to #{user.label.name}")
  end

  def download_client_reminder_email(user)
    @user = user
    mail(:to => user.email, :from => user.label.mail_from, :subject => "Don't forget to download the client") 
  end 

  def setup_completed_email(business)
    @business_name = business.business_name
    @user = business.user
    @url  = "https://#{@user.label.domain}/users/sign_in"
    mail(:to => @user.email, :from => @user.label.mail_from, 
          :subject => "Jobs Completed for #{business.business_name}")
  end

  def custom_email(email, email_body, subject)
    mail(to: email,
         body: email_body,
         content_type: "text/html",
         subject: subject)
  end
end
