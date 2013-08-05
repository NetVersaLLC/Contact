ActiveAdmin.register Label do
  menu :if => proc{ current_user.admin? || current_user.reseller? }

  filter :parent
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
    column :legal_name
    column :domain
    column :label_domain
    column :address
    column :support_email
    column :support_phone
    column :mail_from
    column "Balance", :sortable=>:available_balance do |label|
      number_to_currency(label.available_balance)
    end
    column :credit_limit, :sortable=>:credit_limit do |label| 
      number_to_currency(label.credit_limit) 
    end 
    #if current_user.admin?
    #  column :login
     # column :password
    #end 
    default_actions
  end

  show do |label| 
    attributes_table do 
      row :name 
      row :legal_name
      row :domain 
      row :label_domain
      row :address
      row :support_email
      row :support_phone
      row :mail_from 
      row("package_signup_rate")       { number_to_currency(label.package_signup_rate) } 
      row("package_subscription_rate") { number_to_currency(label.package_subscription_rate) } 
      row("Available Balance"){ number_to_currency(label.available_balance) } 
      row("Credit Limit"){number_to_currency(label.credit_limit)}
      row("Credit Limit Held by Sub Lables"){ number_to_currency( label.credit_held_by_children) }
      row("Funds Available"){number_to_currency(label.funds_available)}
      row :favicon_image do
        image_tag(label.favicon.url(:thumb))
      end
      row :image do 
        image_tag(label.logo.url(:thumb)) 
      end
      if current_user.admin?
        row :login 
        row :password
      end 
      row :parent 
      row("Users"){label.users.where( 'access_level <= ?', User.reseller ).collect { |user| "#{ user.email  } (#{ user.role_is })" 
}.to_sentence.html_safe}
      row :custom_css 
      row :footer
    end 
  end 

  form do |f|
    f.inputs do
      f.input :name
      f.input :legal_name
      f.input :domain 
      f.input :label_domain
      f.input :address
      f.input :support_email
      f.input :support_phone
      f.input :mail_from
      f.input :package_signup_rate
      f.input :package_subscription_rate
      f.input :credit_limit
      f.input :favicon, :as => :file
      f.input :logo, :as => :file 
      if current_user.admin?
        f.input :login 
        f.input :password , :input_html => { :value => f.object.password } ,:as => :string
      end 
      f.input :custom_css # text area 
      f.input :footer # text area
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
