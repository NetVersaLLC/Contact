ActiveAdmin.register Coupon do
  scope_to :current_user

  config.comments = false
  index do
    column :name
    column :code
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :name 
      f.input :code 
      f.input :allowed_upto
      f.input :use_discount, :as => :select,      :collection => {"Dollars"=>:dollars, "Percentage"=> :percentage}
      f.input :dollars_off_monthly 
      f.input :dollars_off_signup
      f.input :percentage_off_monthly
      f.input :percentage_off_signup 
    end
    f.actions
  end 

end
