ActiveAdmin.register Coupon do
  scope_to :current_user

  index do
    column :name
    column :code
    default_actions
  end
end
