ActiveAdmin.register Payload do
  index do
    column :name
    column :data_generator
    default_actions
  end
  member_action :list, :method => :get do
    @payloads = Payload.where(:payload_category_id => params[:id]).order(:position)
    render json: @payloads
  end
end
