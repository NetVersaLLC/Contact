class MyDevise::RegistrationsController < Devise::RegistrationsController

  def new_old
    @callcenter = false
    if params[:callcenter] == '1'
      @callcenter = true
    end
    @password =  Devise.friendly_token.first(10)
    @is_checkout_session = checkout_setup
    super
  end

  def new 
    @user = User.new
    @package = Package.find(params[:package_id])

    respond_to do |format|
      format.html { render :new, layout: "layouts/devise/sessions" }
    end 
  end 

  def create
    build_resource

    # put this on the form
    resource.label_id = current_label.id

    if resource.save
      sign_up(resource_name, resource)
      label_processsor = LabelProcessor.new( current_label ) 

      transaction = label_processsor.create_business( resource, 
                      params[:coupon], 
                      params[:creditcard], 
                      params[:package_id]) 

      if transaction.is_success?
        set_flash_message :notice, :signed_up if is_navigational_format?
        User.delay.send_welcome(resource)
        redirect_to edit_business_path(transaction.business)
      else
        #flash[:notice] = @transaction.message
        errors.push @transaction.message
      end
    else 
      clean_up_passwords resource
      respond_with resource,:location => after_inactive_sign_up_path_for(resource)

      clean_up_passwords resource
      resource.delete # should be resource.destroy
      render :action=>:new
    end 

  end


  def create_old
    STDERR.puts "Ues running"
    if params[:callcenter] and params[:callcenter] =~ /1/i
      @callcenter = true
    else
      @callcenter = false
    end

    build_resource
    resource.callcenter = @callcenter 
    resource.temppass = Random.rand(899999) + 100000

    if @callcenter == true 
      resource.password = resource.password_confirmation = resource.temppass
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
    ActiveRecord::Base.transaction do
      resource.label_id = current_label.id
      unless resource.save 
        clean_up_passwords resource
        render :action=>:new
      end 

      if @is_checkout_session == true
        label_processsor = LabelProcessor.new( current_label ) 

        @transaction = label_processsor.create_business( resource, 
                      params[:coupon], 
                      params[:creditcard], 
                      params[:package_id]) 

        if @transaction.is_success?
          flash[:notice] = "Signed up"
        else
          #flash[:notice] = @transaction.message
          @errors.push @transaction.message
        end
      end

      if @errors.length == 0 
	      unless resource.save 
	        clean_up_passwords resource
	        render :action=>:new
	      end
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(resource_name, resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
        end
  
        User.delay.send_welcome(resource)
        if @is_checkout_session == true
          if !@transaction.business.subscription.active || @transaction.business.subscription.active.nil?
            Notification.add_activate_subscription @transaction.business
          end 
          redirect_to edit_business_path(@transaction.business)
        else
          redirect_to '/resellers'
        end
      else
        STDERR.puts "Redirecing to: new_user_registration_path"
        STDERR.puts "Errors: #{@errors.to_json}"
        STDERR.puts "Resource: #{resource.inspect}"
        clean_up_passwords resource
        resource.delete # should be resource.destroy
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
    #if @package.label_id != current_label.id
    #  throw "Not a valid label!"
    #end
    #@coupon       = Coupon.where(:label_id => current_label.id, :code => params[:coupon]).first
    @coupon        = Coupon.get_available_for( current_label, params[:coupon] ).first
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

  def process_coupon 
    checkout_setup

    render :partial => "sign_up_billing_summary", :layout => false 
  end 

  def after_update_path_for(resource)
    businesses_url
  end

end

