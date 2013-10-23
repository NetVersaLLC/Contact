ActiveAdmin.register User do
  #scope_to :current_user, :association_method => :user_scope

  filter :label, as: :select, :collection => proc { Label.accessible_by(current_ability) } 
  filter :email 
  filter :access_level,  as: :select, :collection => Hash[User::TYPES.map{|k,v| [k.to_s.humanize, v]}] 
  filter :created_at 
  filter :updated_at
  filter :callcenter
  filter :last_sign_in_at

  index do
    column :email
    column :sign_in_count
    column :businesses do |v|
      links = []
      v.businesses.each do |b|
        links.push "<a href='/admin/client_manager?business_id=#{b.id}'>#{b.business_name}</a>"
      end
      raw links.join(", ")
    end

    actions do |user| 
      if user.id != current_user.id && user.owner? 
        link_to "Impersonate", new_impersonation_path(user)
      end 
    end 
  end

  show do |user| 
    attributes_table do 
      row :id
      row("Name"){"#{user.prefix} #{user.first_name} #{user.middle_name} #{user.last_name}"}
      row :email 
      row("Access Level"){user.role_is}
      row :date_of_birth 
      row :mobile_phone 
      row :mobile_appears 
      row :username 
      row("Business"){user.businesses.pluck(:business_name).to_sentence.html_safe }
      row :reset_password_sent_at 
      row :sign_in_count 
      row :current_sign_in_at
      row :last_sign_in_at 
      row :last_sign_in_ip 
      row :current_sign_in_ip 
      row :created_at 
      row :updated_at 
      row :label 
      row :callcenter 
      row :referrer_code 
    end 
  end 

  form do |f|
    f.inputs "Edit User" do
      f.input :email
      #f.input :authentication_token
      f.input :password 
      f.input :password_confirmation 
      f.input :access_level, as: :select, :collection => Hash[User::TYPES.select{|k,v| v >= current_user.access_level}.map{|k,v| [k.to_s.humanize, v]}] 
    end
    f.buttons
  end
  
  controller do
    def scoped_collection 
      User.accessible_by(current_ability)
    end 

    def destroy
      user = User.find(params[:id])
      if user.destroy
        redirect_to admin_users_url, :notice => 'User was successfully deleted'
      else
        redirect_to admin_users_url, :notice => "User can't be deleted"
      end
    end
  end

  #member_action :new, :method => :get do
  #  @user = User.new
  #end
  member_action :create, :method => :post do
    @user = User.new do |u| 
      u.email = params[:user][:email] 
      u.password = params[:user][:password] 
      u.password_confirmation = params[:user][:password_confirmation] 
      u.access_level = params[:user][:access_level] 
    end 

    @user.label_id = current_user.label.id
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'Created your User profile.' }
      else
        logger.info @user.errors.inspect
        format.html { render action: "new" }
      end
    end
  end
  member_action :update, :method => :put do
    @user = User.find(params[:id])
    unless params[:user][:password].blank?
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password]
    end 
    @user.access_level = params[:user][:access_level] 
    @user.save
    redirect_to admin_users_path, :notice => "User updated."
  end
end
