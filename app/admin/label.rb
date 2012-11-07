ActiveAdmin.register Label do
  index do
    column :id
    column :name
    column :domain
    default_actions
  end
end
