ActiveAdmin.register Payload do
  collection_action :list_categories, :method => :get do

    render json: @jobs
  end
end
