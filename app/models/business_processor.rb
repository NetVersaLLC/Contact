class BusinessProcessor

  def initialize( credit_card_processor ) 
    @credit_card_processor = credit_card_processor 
  end 

  def update_a_business( user, package, business )
    get_the_money user, package, business, nil 
  end 


  def create_a_business( user, package, coupon_code )

    coupon = Coupon.where(:label_id => user.label_id, :code => coupon_code ).first
    package.apply_coupon( coupon ) 

    get_the_money user, package, nil, coupon 

  end 

  private 
  def get_the_money( user, package, business, coupon )

    transaction_event = TransactionEvent.new 
    transaction_event.package = package 
    transaction_event.coupon = coupon 
    transaction_event.label = user.label 
    transaction_event.price =  package.price 
    transaction_event.original_price = package.original_price 
    transaction_event.monthly_fee = package.monthly_fee 
    transaction_event.saved = package.saved

    # get business payment 
    payment = @credit_card_processor.charge( package.price * 100 ) 
    transaction_event.payment = payment
    unless payment.status == :success 
      transaction_event.message  = payment.message
      transaction_event.status   = payment.status
      transaction_event.payment  = payment
      transaction_event.save
      return transaction_event
    end 

    # set up a subscription
    subscription  = @credit_card_processor.monthly_recurring_charge(package.monthly_fee * 100 )
    subscription.package = package
    subscription.label_id = user.label_id

    transaction_event.subscription = subscription  

    if subscription.status == :success 
      transaction_event.message = "Purchase complete" 
      transaction_event.status = :success 
    else 
      transaction_event.message = subscription.message 
      transaction_event.status  = subscription.status 

      @credit_card_processor.refund( payment )
      transaction_event.save 
      return transaction_event
    end 

    # create the business
    if business.nil? 
      business = Business.new 
      business.subscription = subscription 
      business.user = user 
      business.save :validate => false 
    else 
      business.update_column( :subscription_id, subscription.id) 
    end 

    transaction_event.business = business 
    transaction_event.save 

    payment.business = business 
    payment.transaction_event = transaction_event 
    payment.label = user.label 
    payment.save 

    subscription.business = business 
    subscription.package = package 
    subscription.label = user.label 
    subscription.transaction_event = transaction_event 
    subscription.save

    transaction_event
  end 

end 
