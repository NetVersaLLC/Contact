ActiveAdmin.register Label do
  index do
    column :id
    column :name
    column :domain
    default_actions
  end

  member_action :xyzzy, :method => :get do
    @label = Label.find(params[:id])
  end
end
