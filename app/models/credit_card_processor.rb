class CreditCardProcessor

  def initialize( label, card_hash )
    @label = label
    @creditcard = ActiveMerchant::Billing::CreditCard.new(card_hash) if card_hash

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

  def is_credit_card_valid? 
    @creditcard.valid?
  end 
  def credit_card_errors 
    return "" if is_credit_card_valid? 

    message = "Credit card is not valid"
    @creditcard.errors.select{|k,v| !v.empty? }.each { |k,v|
    message = "#{message}<br>- #{k.humanize} : #{v.join}"
    }
    message.html_safe
  end 

  #
  #
  #
  #
  def charge( amount ) 
    payment = Payment.new 
    payment.amount = amount
    payment.label = @label

    if amount == 0 
      payment.message = "Free checkout"
      payment.status = :success
    elsif !self.is_credit_card_valid? 
      payment.message = self.credit_card_errors 
      payment.status = :failure
    elsif
      response = @gateway.purchase( amount, @creditcard ) 
      #payment.response = response 
      if response.success?
        payment.message = response.message
        payment.transaction_number = response.params['transaction_id']
        payment.status = :success 
      else
        m = case response.params['response_reason_code']
          when '78'; 'The card code is invalid. Please check your Security code.'
          else; response.message
        end
        payment.message = m 
        payment.status  = :failure
      end
    end 
    payment.save 
    payment
  end 

  #
  #
  #
  #
  def refund( payment )
    response =  @gateway.refund(payment.amount, 
                                payment.transaction_number, 
                                {:card_number => @creditcard.number } )

    if response.success?
      payment.status = :refunded
    else
      payment.status = :refund_failed
      payment.message = response.message
    end

    payment.save 
    payment
  end 

  #
  #
  #
  #
  def monthly_recurring_charge( monthly_fee )
    if monthly_fee == 0
      return Subscription.create( :message => "Free checkout", :status => :success, monthly_fee: monthly_fee, :active => true )
    end 
    if !self.is_credit_card_valid? 
      return Subscription.create( :message => self.credit_card_errors, 
                                 :status => :failure, 
                                 monthly_fee: monthly_fee)
    end 

    names            = @creditcard.name.split(/\s+/)
    first_name       = names.shift
    last_name        = names.join(" ")

    response = @gateway.recurring( monthly_fee, @creditcard, {
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
    subscription.monthly_fee = monthly_fee
    if response.success?
      subscription.active            = true
      subscription.status            = :success
      subscription.message           = "Purchase complete!"
      subscription.subscription_code = response.authorization
    else
      m = 
        case response.params['code']
          when "E00012"; "<strong>Subscription Error!</strong><br>An error occurred while processing subscription of payment. You have submitted a duplicate of Subscription. Please check your Credit card number and try again.".html_safe
          else; response.message
        end
      subscription.active            = false
      subscription.status            = :failed
      subscription.message           = m
    end
    subscription.save validate: false; 
    subscription 
  end 


  #
  #
  #
  def cancel_recurring( subscription ) 
    response = @gateway.cancel_recurring(subscription.subscription_code)
    if subscription.subscription_code.blank? 
      subscription.update_attributes({status: :cancelled, active: :false} )
      return subscription 
    end 

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
