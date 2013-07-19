ActiveAdmin.register Label do
  menu :if => proc{ current_user.admin? || current_user.reseller? }

  filter :name
  filter :domain
  filter :mail_from

  #scope_to :current_user

  controller do
    def scoped_collection
      if current_user.admin? 
        Label.unscoped #current_user.label
      else 
        current_user.label.children
      end 
    end 
  end 

  index do
    column :id
    column :name
    column :domain
    if current_user.admin?
      column :login
      column :password
    end 
    default_actions
  end

  show do |label| 
    attributes_table do 
      row :name 
      row :domain 
      row :image do 
        image_tag(label.logo.url(:thumb)) 
      end
      row :favicon_image do
        image_tag(label.favicon.url(:thumb))
      end
      row :custom_css 
      if current_user.admin?
        row :login 
        row :password
      end 
      row :footer
      row :parent 
      row :credits 
      row :mail_from 
    end 
  end 

  form do |f|
    f.inputs do
      f.input :name
      f.input :domain 
      f.input :logo, :as => :file 
      f.input :favicon, :as => :file
      f.input :custom_css # text area 
      if current_user.admin?
        f.input :login 
        f.input :password , :input_html => { :value => f.object.password } ,:as => :string
      end 
      f.input :footer # text area
      f.input :mail_from
    end

    f.actions 
  end 

  member_action :xyzzy, :method => :get do
    @label = Label.find(params[:id])
  end

  member_action :plow, :method => :put do
    label = Label.find(params[:id])
    params[:label].delete(:password) if params[:label][:password].blank? 

    if label.update_attributes(params[:label])
      flash[:notice] = 'Updated'
    else
      flash[:notice] = 'Error'
    end
    redirect_to "/admin/my_label"
  end
end
