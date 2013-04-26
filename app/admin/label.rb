ActiveAdmin.register Label do
  menu :if => proc{ current_user.admin? }
  scope_to :current_user

  index do
    column :id
    column :name
    column :domain
    default_actions
  end

  show do |label| 
    attributes_table do 
      row :name 
      row :domain 
      row :image do 
        image_tag(label.logo.url(:thumb)) 
      end 
      row :custom_css 
      row :login 
      row :footer 
      row :parent 
      row :credits 
      row :mail_from 
    end 
  end 

  form do |f|
    f.inputs do 
    #f.input :parent # mass assigment not allowed 
    f.input :name 
    f.input :domain 
    f.input :logo, :as => :file 
    
    f.input :custom_css # text area 
    f.input :login 
    f.input :password 
    f.input :footer # text area 
    #f.input :credits # mass asignment notn allowed.  
    f.input :mail_from
    end 

    f.actions 
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
