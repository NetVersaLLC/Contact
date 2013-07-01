ActiveAdmin.register User do
  scope_to :current_user, :association_method => :user_scope
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

    column :links do |resource|
      links = ''.html_safe
      if controller.action_methods.include?('show')
        links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
      end
      if controller.action_methods.include?('edit')
        links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
      end
      if controller.action_methods.include?('destroy')
        links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => 'Are you sure you want to delete this?  All associated records will also be delete.', :class => "member_link delete_link"
      end
      links
    end
  end

  form do |f|
    f.inputs "Edit User" do
      f.input :email
      f.input :authentication_token
      f.input :password
    end
    f.buttons
  end
  
  controller do
    def destroy
      user = User.find(params[:id])
      if user.destroy
        redirect_to admin_users_url, :notice => 'User was successfully deleted'
      else
        redirect_to admin_users_url, :notice => "User can't be deleted"
      end
    end
  end

  member_action :new, :method => :get do
    @user = User.new
  end
  member_action :create, :method => :post do
    @user = User.new(params[:user])
    @user.label_id = current_label.id
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
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password]
    @user.save
  end
end
