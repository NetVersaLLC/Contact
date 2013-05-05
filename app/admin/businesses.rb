ActiveAdmin.register Business do
  scope_to :current_user, :association_method => :business_scope
  actions :all, :except => [:new] 

  filter :redeemed_coupon, :label => "Coupon",
         :as => :select, :collection => proc { Coupon.where(:label_id => current_user.label.id) }
  preserve_default_filters!

  form :partial => 'form'

  index do
    column :business_name, :sortable => :business_name do |v|
      link_to(v.business_name, "/admin/client_manager?business_id=#{v.id}")
    end
    column "Business ID" do |v|
      v.id
    end
    column :company_website do |v|
      link_to v.company_website, v.company_website
    end
    column :parent do |v|
      v.user.label.name
    end
    column :coupon do |v|
      unless v.transaction_event.nil? || v.transaction_event.coupon.nil?
        v.transaction_event.coupon.name
      end
    end

    column :client_checkin

    #actions do |post| 
    column do |v|
      link_to("Categories", "/admin/categories?business_id=#{v.id}")
    end

    column :links do |resource|
      links = ''.html_safe
      if controller.action_methods.include?('show')
        links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
      end
      if controller.action_methods.include?('edit')
        links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
      end
      if controller.action_methods.include?('destroy')
        links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => 'Are you sure you want to delete this?  All associated records will also be delete.', :class => "member_link delete_link"
      end
      links
    end
  end

  controller do
    #def new
    #  @business = Business.new( params[:business] ) 
    #  @business.user = current_user
    #  if @business.save 
    #    flash[:notice] = "Business created" 
    #  else 
    #    flash[:alert] = "The system failed to create your business." 
    #  end 
    #  redirect_to admin_businesses_path 
    #end 

    def show
      @business = Business.accessible_by(current_user).find(params[:id])
      show! do |format|
        format.html { redirect_to edit_business_path(@business), :notice => 'Updated business' }
      end
    end

    def destroy
      @business = Business.find(params[:id])
      if @business.destroy
        redirect_to admin_businesses_url, :notice => 'Business was successfully deleted'
      else
        redirect_to admin_businesses_url, :notice => "Business can't be deleted"
      end
    end

  end

  member_action :client_info, :method => :get do
    @business = Business.find(params[:id])
    @data = {}
    @data['Last Checkin'] = @business.client_checkin
    @data['Updated'] = @business.updated_at
    @data['Created At'] = @business.created_at
    render json: @data
  end
end
