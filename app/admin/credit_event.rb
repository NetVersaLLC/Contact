ActiveAdmin.register CreditEvent do
  actions :index 

  filter :label 
  filter :action 
  filter :note 
  filter :created_at 
  filter :charge_amount 
  filter :post_available_balance 


  index do 
    column :created_at 
    column :action 
    column "Amount", :sortable => :charge_amount do |credit_event| 
      number_to_currency(credit_event.charge_amount)
    end 
    column "Balance", :sortable => :post_available_balance do |credit_event| 
      number_to_currency(credit_event.post_available_balance) 
    end 
    column :note
  end 

  form partial: "form"

  controller do 

    def new
      @credit_event = CreditEvent.new
      @credit_event.other = Label.find(params[:other_id])

      raise CanCan::AccessDenied  unless can? :edit, @credit_event.other
    end 

    # create the transfer 
    def create 
      other = Label.accessible_by(current_ability).find(params[:credit_event][:other_id]) 
      raise CanCan::AccessDenied  unless other.parent_id == current_label.id 

      ce = LabelProcessor.new(current_label).transfer_funds(other, params[:credit_event][:charge_amount])
      flash[:notice] = (ce.status == :success ? 'Transfer succeeded' : "Transfer failed. #{ce.note}" )

      redirect_to admin_dashboard_path 
    end 
  end 

end 
