ActiveAdmin.register Business do
  scope_to :current_user, :association_method => :business_scope
  actions :all, :except => [:new]

  filter :label
  filter :redeemed_coupon, :label => "Coupon",
         :as => :select, :collection => proc { Coupon.where(:label_id => current_user.label.id) }
  filter :business_name
  filter :company_website
  filter :client_checkin
  filter :business_name
  filter :corporate_name
  filter :categorized
  filter :is_client_downloaded


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
    if current_user.reseller?
      column :impersonate do |v| 
        unless v.user.nil? || cannot?(:manage, v.user)
          link_to 'Login', new_impersonation_path(v.user) #"/impersonate/user/205"
        end 
      end 
    end 
    column :coupon do |v|
      unless v.transaction_event.nil? || v.transaction_event.coupon.nil?
        v.transaction_event.coupon.name
      end
    end

    column :client_checkin do |v|
      if v.client_checkin.nil?
        "Never"
      else
        distance_of_time_in_words_to_now(v.client_checkin)
      end
    end

    column :categorized, sortable: :categorized do |v| 
      v.categorized ? "Yes" : "No"
    end
    column do |v|
      link_to("Categories", "/admin/categories?business_id=#{v.id}")
    end

    column :links do |resource|
      links = ''.html_safe
      if controller.action_methods.include?('show')
        links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
      end
      #if controller.action_methods.include?('edit')
      #  links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
      #end
      if controller.action_methods.include?('destroy')
        links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => 'Are you sure you want to delete this?  All associated records will also be delete.', :class => "member_link delete_link"
      end
      links
    end
  end

  controller do
    def destroy
      @business = Business.find(params[:id])

      #if @business.destroy
      if LabelProcessor.new(current_label).destroy_business(@business)
        redirect_to admin_businesses_url, :notice => 'Business was successfully deleted'
      else
        redirect_to admin_businesses_url, :notice => "Business can't be deleted"
      end
    end

    def new
      @business = Business.new(params[:business])
      @business.user = current_user
      if @business.save
        flash[:notice] = "Business created"
      else
        flash[:alert] = "The system failed to create your business."
      end
      redirect_to admin_businesses_path
    end

    def show
      @business = Business.find(params[:id])
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