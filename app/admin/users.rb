ActiveAdmin.register User do
  index do
    column :email
    column :sign_in_count
    default_actions
  end
end
