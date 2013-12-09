class ReceiptMailer < ActionMailer::Base 
  def purchase_email( business ) 
    @business = business

    to = business.user.email
    from = business.label.support_email
    subject = business.label.name + " Purchase"

    mail( to: to, from: from, subject: subject) 
  end 

  def subscription_email( business ) 
  end 

end 
