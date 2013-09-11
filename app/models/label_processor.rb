class LabelProcessor
  def initialize( label ) 
    @label = label
  end 

  

  #def initialize( credit_card_processor ) 
  #  @credit_card_processor = credit_card_processor 
  #end 

  def renew_business_subscription( user, package, business, credit_card)
    charge_and_subscribe user, package, business, nil, credit_card
  end 

  def credit_card_processor(credit_card_info)
     CreditCardProcessor.new(@label, credit_card_info ) 
  end 

  def create_business( user, coupon_code, credit_card, package_id )
    coupon = Coupon.where(:label_id => user.label_id, :code => coupon_code ).first
    package = Package.find(package_id)
    package.apply_coupon( coupon ) 

    charge_and_subscribe user, package, nil, coupon, credit_card
  end 

  def destroy_business( business ) 
    ccp = CreditCardProcessor.new(@label)
    ccp.cancel_recurring( business.subscription ) 

    business.destroy
  end 

  def add_funds( to_label, amount, memo )
    damount = BigDecimal.new(amount)

    source = @label
    dest = to_label

    # atomic update
    Label.update_all("available_balance = available_balance + #{amount}", {id: dest.id}) 
    dest.reload

    cf = CreditEvent.create( label_id: dest.id,
                        other_id: source.id,
                        note: "#{source.name} added funds", 
                        charge_amount: damount, 
                        action: "payment",
                        memo: memo,
                        status: :success, 
                        post_available_balance: dest.available_balance )

    tc = cf.generate_transaction_code 
    cf.update_attribute(:transaction_code, tc + '-S') 
    cf
  end 

  #
  # Debit the label's account, and each parent up the tree.  
  #
  def debit_sign_up user, transaction_event, label
    return if label.nil?

    # It's ok if the balance goes negative, we want the sign up either way. This is an atomic update 
    Label.update_all("available_balance = available_balance - package_signup_rate", {id: label.id}) 
    label.reload

    ce = CreditEvent.create(label_id: label.id, 
                       user_id: user.id, 
                       charge_amount: (-1) * label.package_signup_rate, 
                       post_available_balance: label.available_balance, 
                       note: "Business sign up",
                       action: "sign up", 
                       transaction_event_id: transaction_event.id)

    debit_sign_up(user, transaction_event, label.parent)
  end 

  # 
  # Each month, debit the label for each active subscription.  
  # Care has been taken so that this job, which usually runs from a cron -> rake task, can safely 
  # be re-run in case an error occurs. 
  # 
  def debit_monthly_subscriptions 
    ccp = CreditCardProcessor.new(@label)

    # subscriptions dont start for atleast a month after being created. 
    # filter out any recently billed subscriptions.  This allows a job to rerun safely if an error occurs.
    @label.subscriptions.where('created_at < ? and label_last_billed_at <= ?', 1.month.ago, 1.month.ago).where(status: :success).each do |subscription| 
      if ccp.valid_recurring( subscription )
        debit_monthly_subscription @label, subscription
      end 
    end 
  end 

  private 
  def debit_monthly_subscription label, subscription
    Label.update_all("available_balance = available_balance - package_subscription_rate", {id: label.id}) 
    label.reload

    ce = CreditEvent.create(label_id: label.id, 
                       charge_amount: (-1) * label.package_signup_rate, 
                       post_available_balance: label.available_balance, 
                       note: "monthly business subscription fee",
                       action: "monthly subscription", 
                       subscription: subscription )

    # this to help filter out recently charged subscriptions if a job needs to be rerun 
    # due to some failure. 
    subscription.update_attribute(label_last_billed_at: Time.now ) 

    debit_monthly_subscription( label.parent, subscription ) unless label.parent.nil?
  end 

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
    subscription  = ccp.monthly_recurring_charge(package.monthly_fee * 100)
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
      business.label = @label
      business.save :validate => false 
    else 
      business.update_column( :subscription_id, subscription.id) 
    end 

    transaction_event.business = business
    transaction_event.save 

    debit_sign_up user, transaction_event, @label

    payment.business = business 
    payment.transaction_event = transaction_event 
    payment.label = @label
    payment.save 

    subscription.transaction_event = transaction_event 
    subscription.save

    transaction_event
  end 

end 
