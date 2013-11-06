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
    build_resource

    @package = Package.where(id: params[:package_id]).first

    resource.label_id = current_label.id
    if resource.callcenter
      resource.password = resource.password_confirmation = resource.temp_password = SecureRandom.random_number(1000000)
    end 

    if resource.save
      sign_up(resource_name, resource)

      if @package.nil?
        redirect_to "/resellers"
      else 
        label_processsor = LabelProcessor.new( current_label ) 

        transaction = label_processsor.create_business( resource, 
                        params[:coupon], 
                        params[:creditcard], 
                        params[:package_id]) 

        if transaction.is_success?
          set_flash_message :notice, :signed_up if is_navigational_format?
          User.send_welcome(resource).deliver
          redirect_to edit_business_path(transaction.business)
        else
          #flash[:notice] = @transaction.message
          errors.push @transaction.message
        end
      end 
    else 
      clean_up_passwords resource
      respond_with resource,:location => after_inactive_sign_up_path_for(resource)
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

