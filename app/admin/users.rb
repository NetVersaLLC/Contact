ActiveAdmin.register User do
  index do
    column :email
    column :sign_in_count
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
