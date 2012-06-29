ActiveAdmin.register Booboo do
  index do
    column :business_id do |v|
      v.business.business_name
    end
    column :created_at
    default_actions
  end
end
