ActiveAdmin.register Business do
  form :partial => 'form'

  index do
    column :business_name
    column :company_website do |v|
      link_to v.company_website, v.company_website
    end
    column :client_checkin
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

end
