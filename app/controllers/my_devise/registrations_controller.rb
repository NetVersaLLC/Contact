class MyDevise::RegistrationsController < Devise::RegistrationsController
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  def new
    if params[:package_id].nil?
      @package = Package.first
    else
      @package = Package.find(params[:package_id])
    end
    @coupon = Coupon.where(:label_id => current_label.id, :code => params[:coupon]).first
    @subtotal = @package.price
    unless @coupon.nil?
      @saved      = Package.apply_coupon(@package, @coupon)
    end
    @total = @package.price
    @amount_total = @package.monthly_fee
    @package_id = @package.id
    super
  end

  def create
    build_resource

    if params[:package_id].nil?
      @package = Package.first
    else
      @package = Package.find(params[:package_id])
    end
    @coupon = Coupon.where(:label_id => current_label.id, :code => params[:coupon]).first
    @subtotal = @package.price
    unless @coupon.nil?
      @saved      = Package.apply_coupon(@package, @coupon)
    end
    @total        = @package.price
    @amount_total = @package.monthly_fee
    @package_id   = @package.id

    @name        = params[:name]
    @card_number = params[:card_number]
    @cvv         = params[:cvv]
    @card_month  = params[:card_month]
    @card_year   = params[:card_year]
    @email       = params[:user][:email]

    ActiveRecord::Base.transaction do
      @errors = Subscription.process_transaction(current_label, resource, params)
      resource.label_id = current_label.id
      if resource.save and @errors.length == 0
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(resource_name, resource)
          respond_with resource, :location => after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        respond_with resource
      end
    end
  end

  protected
  def after_sign_up_path_for(resource)
    new_subscription_path
  end
end

