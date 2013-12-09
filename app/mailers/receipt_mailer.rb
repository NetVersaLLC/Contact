class ReceiptMailer < ActionMailer::Base 
  def purchase_email( business, credit_card ) 
    @business = business
    @credit_card = credit_card
    @brand = { 'master' => 'MasterCard', 'visa' => 'Visa', 'american_express' => 'American Express', 'discover' => 'Discover'}[ credit_card[:brand] ]

    to = business.user.email
    from = business.label.mail_from
    subject = business.label.name + " Purchase"

    mail( to: to, from: from, subject: subject) 
  end 

  def subscription_email( business ) 
  end 

end 
