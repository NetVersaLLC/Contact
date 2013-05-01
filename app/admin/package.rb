ActiveAdmin.register Package do
  scope_to :current_user

  controller do
    before_filter :on_before_save, :only=>:create
    private
    def on_before_save
      params[:package][:label_id]=current_label.id if params[:package][:label_id] == nil
    end
  end
end
