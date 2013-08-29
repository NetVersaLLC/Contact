class ReportMailer < ActionMailer::Base
  default from: "support@towncenter.com"

  def report_email(report)
    @report = report
    @url  = "https://#{report.label.domain}/scan/#{report.ident}"
    mail(:to => report.email, :from => report.label.mail_from, :subject => "Your Local Search Report")
  end

end
