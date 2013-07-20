class LabelProcessor
  def initialize( label ) 
    @label = label
  end 

  #def initialize( credit_card_processor ) 
  #  @credit_card_processor = credit_card_processor 
  #end 

  def renew_business( user, package, business, credit_card)
    charge_and_subscribe user, package, business, nil, credit_card
  end 

  def credit_card_processor(credit_card_info)
     CreditCardProcessor.new(@label, credit_card_info ) 
  end 

  def create_business( user, coupon_code, credit_card, package )
    coupon = Coupon.where(:label_id => user.label_id, :code => coupon_code ).first
    package.apply_coupon( coupon ) 

    charge_and_subscribe user, package, nil, coupon, credit_card
  end 

  #
  # transfer funds to a label so they can transact business.  This is usually done 
  # through the active admin panel
  #
  def transfer_funds( to_label, amount )
    damount = BigDecimal.new(amount)

    ce = CreditEvent.new 
    ce.label = @label
    ce.other = to_label 
    ce.charge_amount = -1 * damount
    ce.action = 'transfer funds'
    ce.status = :success

    source = @label
    dest = to_label
    
    Label.transaction do |t|
      source.reload

      if ( source.available_balance < damount ) 
        ce.note = 'Insufficient funds' 
        ce.status = :failed
        raise ActiveRecord::Rollback
      else 
        # atomic updates
        Label.update_all("available_balance = available_balance - #{amount}", {id: source.id}) 
        Label.update_all("available_balance = available_balance + #{amount}", {id: dest.id}) 

        source.reload
        dest.reload

        ce.note = "Transfer to #{dest.name}"
        CreditEvent.create( label_id: dest.id,
                            other_id: source.id,
                            note: "Transfer from #{source.name}", 
                            charge_amount: damount, 
                            action: "transfer funds",
                            post_available_balance: dest.available_balance )
      end 
    end 

    ce.post_available_balance = source.available_balance
    ce.save 
    ce
  end 

  private 
  def charge_and_subscribe( user, package, business, coupon, credit_card)
    ccp = self.credit_card_processor( credit_card )

    transaction_event = TransactionEvent.new 
    transaction_event.package = package 
    transaction_event.coupon = coupon 
    transaction_event.label = @label
    transaction_event.price =  package.price 
    transaction_event.original_price = package.original_price 
    transaction_event.monthly_fee = package.monthly_fee 
    transaction_event.saved = package.saved

    # get business payment 
    payment = ccp.charge( package.price * 100 ) 
    transaction_event.payment = payment
    unless payment.status == :success 
      transaction_event.message  = payment.message
      transaction_event.status   = payment.status
      transaction_event.payment  = payment
      transaction_event.save
      return transaction_event
    end 

    # set up a subscription
    subscription  = ccp.monthly_recurring_charge(package.monthly_fee * 100 )
    subscription.business = business 
    subscription.package = package 
    subscription.label = @label

    transaction_event.subscription = subscription  

    if subscription.status == :success 
      transaction_event.message = "Purchase complete" 
      transaction_event.status = :success 
    else 
      transaction_event.message = subscription.message 
      transaction_event.status  = subscription.status 

      ccp.refund( payment )
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

    # It's ok if the balance goes negative, we want the sign up either way
    Label.update_all("available_balance = available_balance - package_signup_rate", {id: @label.id}) 
    @label.reload

    CreditEvent.create(label_id: @label.id, 
                       user_id: user.id, 
                       charge_amount: (-1) * @label.package_signup_rate, 
                       post_available_balance: @label.available_balance, 
                       note: "Business sign up",
                       action: "sign up", 
                       transaction_event_id: transaction_event.id)

    payment.business = business 
    payment.transaction_event = transaction_event 
    payment.label = @label
    payment.save 

    subscription.transaction_event = transaction_event 
    subscription.save

    transaction_event
  end 

end 
