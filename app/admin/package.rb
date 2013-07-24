ActiveAdmin.register Package do
  scope_to :current_user

  index do 
    column :name
    column "Price", :sortable => :price do |package| 
      number_to_currency(package.price)
    end
    column "Monthly Fee", :sortable => :monthly_fee do |package| 
      number_to_currency(package.monthly_fee) 
    end 
    column :short_description
    actions
  end



  show do |package| 
    attributes_table do 
      row :name
      row :description 
      row :short_description 
      row :price do |price| 
        number_to_currency(package.price)
      end
      row :monthly_fee do |monthly_fee| 
        number_to_currency(package.monthly_fee)
      end
      row :created_at
      row :updated_at
    end 
  end 

  controller do
    before_filter :on_before_save, :only=>:create
    private
    def on_before_save
      params[:package][:label_id]=current_label.id if params[:package][:label_id] == nil
    end
  end
end
