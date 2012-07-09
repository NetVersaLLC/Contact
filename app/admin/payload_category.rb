ActiveAdmin.register PayloadCategory do
  collection_action :list, :method => :get do
    @payloads = PayloadCategory.order(:position)
    render json: @payloads
  end
end
