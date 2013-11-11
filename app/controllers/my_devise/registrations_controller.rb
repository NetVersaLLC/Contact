class MyDevise::RegistrationsController < Devise::RegistrationsController

  def new 
    @user = User.new
    @user.callcenter = params[:callcenter] == "1"

    checkout_setup
    
    respond_to do |format|
      format.html { render :new, layout: "layouts/devise/sessions" }
    end 
  end 

  def create
    @user = User.new( params[:user] )

    @package = Package.where(id: params[:package_id]).first

    @user.label_id = current_label.id
    if @user.callcenter
      @user.password = @user.password_confirmation = @user.temp_password = SecureRandom.random_number(1000000)
    end 

    if @user.save

      if @package.nil?
        sign_up("user", @user)
        redirect_to "/resellers"
      else 
        label_processsor = LabelProcessor.new( current_label ) 

        transaction = label_processsor.create_business( @user, 
                        params[:coupon], 
                        params[:creditcard], 
                        params[:package_id]) 

        if transaction.is_success?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up("user", @user)
          User.send_welcome(@user).deliver
          redirect_to edit_business_path(transaction.business)
        else
          #flash[:notice] = @transaction.message
          #errors.push @transaction.message
          @user.delete 
          @user = User.new({email: @user.email})
          @user.errors.add :credit_card, transaction.message
          checkout_setup
          render :new, layout: "layouts/devise/sessions" 
        end
      end 
    else 
      clean_up_passwords @user 
      render :new, layout: "layouts/devise/sessions" 
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
      @package = nil
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
    #@subtotal     = @package.original_price
    #@total        = @package.price
    #@amount_total = @package.monthly_fee
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

