ActiveAdmin.register Business do
  form :partial => 'form'

  index do
    column :name
    column :website do |v|
      link_to v.website, v.website
    end
    column :approved
    default_actions
  end

  controller do
    def show
      @business = Business.find(params[:id])
      show! do |format|
        format.html { redirect_to edit_admin_business_path(@business), :notice => 'Updated business' }
      end
    end 
  end

end
