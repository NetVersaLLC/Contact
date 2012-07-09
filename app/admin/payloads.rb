ActiveAdmin.register Payload do
  member_action :list, :method => :get do
    @payloads = Payload.where(:payload_category_id => params[:id])
    render json: @payloads
  end
end
