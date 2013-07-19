class LabelMailer < ActionMailer::Base
  default from: "support@towncenter.com"

  def sync_disabled_email(label)
    @label = label
    mail(:to => label.mail_from, :subject => "Sync disabled due to insufficient funds."
  end
end
