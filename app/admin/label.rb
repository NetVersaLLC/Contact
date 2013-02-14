ActiveAdmin.register Label do
  menu :if => proc{ current_user.admin? }
  scope_to :current_user

  index do
    column :id
    column :name
    column :domain
  end

  member_action :xyzzy, :method => :get do
    @label = Label.find(params[:id])
  end

  member_action :plow, :method => :post do
    label = Label.find(params[:id])
    if label.update_attributes(params[:label])
      flash[:notice] = 'Updated'
    else
      flash[:notice] = 'Error'
    end
    redirect_to "/admin/my_label"
  end
end
