ActiveAdmin.register GoogleCategory do

  collection_action :list do
    @type   = params[:type]
    @list   = eval "#{@type}.build_menu"
    @google = GoogleCategory.all
    @key    = eval("#{@type}.get_id_name")
  end

  member_action :update_cat, :method => :put do
    @google = GoogleCategory.find(params[:id])
    @type   = params[:type]
    @name   = eval("#{@type}.get_id_name")
    eval "@google.#{@name} = #{params[:category_id]}"
    @google.save
    logger.info "Value is: " + eval("@google.#{@name}").to_s
    render json: {:status => 'success'}
  end
end
