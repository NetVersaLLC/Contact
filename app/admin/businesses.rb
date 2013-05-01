ActiveAdmin.register Business do
  scope_to :current_user, :association_method => :business_scope

  config.clear_action_items!
  actions :all, :except => :new

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

    default_actions
  end

  controller do
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
