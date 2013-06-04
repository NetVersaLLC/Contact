class MyDevise::RegistrationsController < Devise::RegistrationsController
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  def new
    @callcenter = false
    if params[:callcenter] == '1'
      @callcenter = true
    end
    @password =  Devise.friendly_token.first(10)
    @is_checkout_session = checkout_setup
    if current_label.credits < -99
      redirect_to '/try_again_later'
      return
    end
    super
  end

  def create
    STDERR.puts "Ues running"
    @callcenter = params[:callcenter] == '1' ? true : false
    build_resource
    resource.callcenter = @callcenter 
    if @callcenter == true 
      resource.temppass = resource.password = resource.password_confirmation = Random.rand(899999) + 100000
    end 

    @is_checkout_session = checkout_setup

    unless resource.valid?
      clean_up_passwords resource
      render :action=>:new and return
    end

    if @is_checkout_session == true
      @name        = params[:creditcard][:name]
      @card_number = params[:creditcard][:number]
      @cvv         = params[:creditcard][:verification_value]
      @card_month  = params[:creditcard][:month]
      @card_year   = params[:creditcard][:year]
      @email       = params[:user][:email]
    end

    @errors             = []
    #business            = Business.new
    ActiveRecord::Base.transaction do
      if @is_checkout_session == true
        Coupon.redeem @package, params[:coupon] 

        STDERR.puts "Package: #{@package.inspect}"
        @transaction = TransactionEvent.build(params, @package, current_label)
        @transaction.process()
        if @transaction.is_success?
          flash[:notice] = "Signed up"

          # This seems like the easiest and secure way of doing this 
          # wihtout doing something funny with a model 
          #session[:subscription] = @transaction.subscription.id 

          #do this stuff in the business controller 
          #business.subscription = @transaction.subscription
          #business.save :validate => false
          #@transaction.setup_business(business)
        else
          flash[:notice] = @transaction.message
          @errors.push @transaction.message
        end
      end

      resource.label_id = current_label.id
      if @errors.length == 0 && resource.save
        #if @is_checkout_session == true
          #business.user    = resource
          #business.user_id = resource.id
          #business.save :validate => false
        #end
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(resource_name, resource)
					BusinessFormEdit.create(subscription_id: @transaction.subscription.id, user_id: current_user.id)
          if @is_checkout_session == true
            redirect_to new_business_path #edit_business_path(business)
          else
            redirect_to '/resellers'
          end
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          if @is_checkout_session == true
            redirect_to new_business_path #edit_business_path(business)
          else
            redirect_to '/resellers'
          end
        end
      else
        STDERR.puts "Redirecing to: new_user_registration_path"
        STDERR.puts "Errors: #{@errors.to_json}"
        STDERR.puts "Resource: #{resource.inspect}"
        clean_up_passwords resource
        render :action=>:new
      end
    end
  end

  # protected
  # def after_sign_up_path_for(resource)
  #   new_business_path
  # end
  # private
  def checkout_setup
    if params[:package_id] != nil and params[:package_id].to_i > 0
      @package    = Package.find(params[:package_id])
      @package.original_price = @package.price
    else
      return false
    end
    if @package.label_id != current_label.id
      throw "Not a valid label!"
    end
    #@coupon       = Coupon.where(:label_id => current_label.id, :code => params[:coupon]).first
    @coupon        = Coupon.get_available_for( @package, params[:coupon] ).first
    unless @coupon == nil
      @saved      = @package.apply_coupon(@coupon)
    end
    @subtotal     = @package.original_price
    @total        = @package.price
    @amount_total = @package.monthly_fee
    STDERR.puts "Coupon: #{@coupon.inspect}"
    STDERR.puts "Subtotal: #{@subtotal}"
    STDERR.puts "Total: #{@total}"
    STDERR.puts "Amount: #{@amount_total}"
    return true
  end
end

