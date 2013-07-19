ActiveAdmin.register Booboo do
  menu if: proc{ !current_user.is_reseller? }
  collection_action :list, :method => :get do
    @booboos = Booboo.where('business_id = ?', params[:business_id]).order(:created_at)
    respond_to do |format|
      format.html { render "booboos", layout: false }  
      format.json { render json: @booboos }  
    end 
  end
  member_action :view, :method => :get do
    @booboo = Booboo.find(params[:id])
    render json: @booboo
  end
  index do
    column :business_id
    column :created_at
    column :message do |booboo|
      if booboo.message.length > 100
        booboo.message[0 .. 100] + '...'
      else
        booboo.message
      end
    end
    default_actions
  end
end
