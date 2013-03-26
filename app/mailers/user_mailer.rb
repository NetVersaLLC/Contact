class UserMailer < ActionMailer::Base
  default from: "support@towncenter.com"

  def welcome_email(user)
    @user = user
    @url  = "http://#{user.label.domain}/users/sign_in"
    if user.callcenter == true
      @password = user.temppass
    end
    mail(:to => user.email, :from => user.label.mail_from, :subject => "Welcome to #{user.label.name}")
  end
end
