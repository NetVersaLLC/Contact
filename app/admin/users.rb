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
    default_actions
  end
  form do |f|
    f.inputs "Edit User" do
      f.input :email
      f.input :authentication_token
      f.input :password
    end
    f.buttons
  end
  member_action :update, :method => :put do
    @user = User.find(params[:id])
    @user.password = params[:password]
    @user.password_confirmation = params[:password]
    @user.save
  end
end
