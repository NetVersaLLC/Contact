class CreditCardProcessor

  def initialize( label, card_hash )
    @creditcard = ActiveMerchant::Billing::CreditCard.new(card_hash) 

    if Rails.env.to_sym == :production
      @gateway = ActiveMerchant::Billing::Base.gateway(:authorize_net).new(
        :login    => label.login,
        :password => label.password,
      )
      ActiveMerchant::Billing::Base.mode = :production
    else
      @gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
        :login    => "8e3UfTHKM9d2",
        :password => "5B7t5V6S65m3WkdU",
        :test     => true
      )
      ActiveMerchant::Billing::Base.mode = :test
    end
    STDERR.puts "Got Gateway: #{@gateway.inspect}"
  end 

  def charge( amount ) 
    if amount == 0 
      return Payment.create( :message => "Free checkout", :status => :success ) 
    end 

    response = @gateway.purchase( amount, @credit_card ) 
    if response.success?
      Payment.create( :message => response.message, 
                      :transaction_number => response.params['transaction_id'], 
                      :status => :success ) 
    else
      m = case response.params['response_reason_code']
        when '78'; 'The card code is invalid. Please check your Security code.'
        else; response.message
      end

      Payment.create( :message => m, :status  => :failure ) 
    end
  end 

  def refund( payment, card_number )
    response =  @gateway.refund(payment.amount, payment.transaction_number, {:card_number => card_number } )

    logger.info "Refund response:"
    logger.info response.inspect
    if response.success?
      payment.status = :refunded
    else
      payment.status = :refund_failed
      payment.message = response.message
    end

    payment.save 
    payment
  end 

  def monthly_recurring_charge( monthly_fee )

    names            = @credit_card.name.split(/\s+/)
    first_name       = names.shift
    last_name        = names.join(" ")

    response = @gateway.recurring( monthly_fee, @credit_card, {
      :interval => {
        :unit   => :months,
        :length => 1
      },
      :duration => {
        :start_date  => Date.today,
        :occurrences => 9999
      },
      :billing_address => {
        :first_name => first_name,
        :last_name  => last_name
      }
    })
   
    subscription = Subscription.new 
    if response.success?
      STDERR.puts "Printing response:"
      STDERR.puts response.to_json
      subscription.active            = true
      subscription.status            = :success
      subscription.message           = "Purchase complete!"
      subscription.subscription_code = response.authorization
    else
      subscription.active            = false
      subscription.status            = :failed
      subscription.message           = response.message
    end
    subscription.save!
    subscription 
  end 

  def cancel_recurring( subscription ) 

    response = @gateway.cancel_recurring(subscription.subscription_code)
    if response.success?
      subscription.active  = false
      subscription.status  = :cancelled
      subscription.message = "Subscription cancelled."
    else
      subscription.message = response.message
      subscription.status  = :failed_cancellation
    end

    subscription.save!
    subscription 
  end 

end 
