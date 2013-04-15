ActiveAdmin.register Business do
  scope_to :current_user, :association_method => :business_scope

  form :partial => 'form'

  index do
    column :business_name do |v|
      link_to(v.business_name, "/admin/client_manager?business_id=#{v.id}") 
    end
    column "Business ID" do |v|
      v.id
    end
    column :company_website do |v|
      link_to v.company_website, v.company_website
    end
    column :client_checkin
   
    # This can be merged with an actions method (instead of default_actions) when 
    # activeadmin upgraded to 0.6.0, released on 4/4/2013.   
    column  do |v|
      link_to("Categories", "/admin/categories?business_id=#{v.id}")
    end 

    default_actions
  end

  controller do
    def show
      @business = Business.find(params[:id])
      show! do |format|
        format.html { redirect_to edit_business_path(@business), :notice => 'Updated business' }
      end
    end 
  end

  member_action :client_info, :method => :get do
    @business = Business.find(params[:id])
    @data = {}
    @data['Last Checkin'] = @business.client_checkin
    @data['Updated']      = @business.updated_at
    @data['Created At']   = @business.created_at
    render json: @data
  end
end
