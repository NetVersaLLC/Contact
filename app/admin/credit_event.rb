ActiveAdmin.register CreditEvent do
  menu false 
  scope_to :current_label

  index do 
    column :created_at 
    column :action 
    column :quantity 
    column :other do |v| 
      v.other.name 
    end 
    column :user
  end 

  form do |f|
    f.inputs "Transfer to #{resource.other.name}" do
      f.input :other_id, :as => :hidden, :value => resource.other.id
      f.input :quantity
    end 
    f.actions do 
      f.action :submit, :label => "Transfer Credits" 
    end 
  end 

  controller do 
    def new 
      @credit_event = CreditEvent.new 
      @credit_event.other = Label.find(params[:other_id])

      raise CanCan::AccessDenied  unless @credit_event.other.parent_id == current_label.id 
    end 

    # create the transfer 
    def create 
      other = Label.accessible_by(current_ability).find(params[:credit_event][:other_id]) 
      raise CanCan::AccessDenied  unless other.parent_id == current_label.id 
      current_label.transfer_to( other, params[:credit_event][:quantity], current_user) 

      redirect_to admin_dashboard_path 
    end 
  end 

end 
