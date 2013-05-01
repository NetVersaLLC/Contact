ActiveAdmin.register Label do
  menu :if => proc{ current_user.admin? }
  scope_to :current_user

  index do
    column :id
    column :name
    column :domain
    column :login
    column :password
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
      row :password
      row :footer
      row :parent 
      row :credits 
      row :mail_from 
    end 
  end 

  form do |f|
    label = Label.find(params[:id])
    f.inputs do
    f.input :name
    f.input :domain 
    f.input :logo, :as => :file 
    
    f.input :custom_css # text area 
    f.input :login 
    f.input :password , :input_html => { :value => label.password } ,:as => :string
    f.input :footer # text area
    f.input :mail_from
    end 

    f.actions 
  end 

  member_action :xyzzy, :method => :get do
    @label = Label.find(params[:id])
  end

  member_action :plow, :method => :post do
    label = Label.find(params[:id])
    label.is_pdf = false if params[:is_pdf].blank?
    label.is_show_password = false if params[:is_show_password].blank?
    if label.update_attributes(params[:label])
      flash[:notice] = 'Updated'
    else
      flash[:notice] = 'Error'
    end
    redirect_to "/admin/my_label"
  end
end
