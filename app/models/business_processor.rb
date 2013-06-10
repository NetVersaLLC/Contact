class BusinessProcessor

  def create_a_business( user, package, coupon, credit_card )
    transaction_event = TransactionEvent.new 
    transaction_event.package = package 
    transaction_event.label = user.label 
    transaction_event.price =  package.price 
    transaction_event.original_price = package.original_price 
    transaction_event.monthly_fee = package.monthly_fee 
    transaction_event.saved = package.saved 


    cc = CreditCardProcessor.new( user.label, credit_card )

    # get business payment 
    # TODO transaction event     
    payment = cc.charge( package.price * 100 ) 
    payment.label = user.label 

    if payment.status == :success 

    else 

    end 

    
    # set up a subscription
    subscription  = cc.monthly_recurring_charge(  )     

    # if subscription failed 


    
    # create the business 

    # return business  

  end 

end 
