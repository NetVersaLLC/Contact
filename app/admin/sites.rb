ActiveAdmin.register Site do
  menu false
  admin_sub_menu

  index do
    column :name
    column :owner
    column :page_rank
    default_actions
  end
end
