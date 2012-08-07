ActiveAdmin.register GoogleCategory do

  collection_action :index do
    @blah = 'Fah'
    render 'list'
  end
end
