ActiveAdmin.register Coupon do
  index do
    column :name
    column :code
    default_actions
  end
end
