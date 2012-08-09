ActiveAdmin.register Booboo do
  collection_action :list, :method => :get do
    @booboos = Booboo.where('business_id = ?', params[:business_id]).order(:created_at)
    render json: @booboos
  end
  member_action :view, :method => :get do
    @booboo = Booboo.find(params[:id])
    render json: @booboo
  end
  index do
    column :business_id
    column :created_at
    default_actions
  end
end
