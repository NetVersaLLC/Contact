ActiveAdmin.register Job do
  index do
    column :user_id
    column :name
    column :model
    column :status
    column :created_at
    column :waited_at
    default_actions
  end
end
