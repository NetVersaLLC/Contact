class ActiveAdminFooter < ActiveAdmin::Component
  def build
    super(id: "footer") 
    span "Copyright #{Date.today.year} Netversa, LLC "
    if current_user.admin?
      conn = ActiveRecord::Base.connection_config().select{|k,v| [:host, :database].include?(k) }
      span "[db=#{conn}]"
    end 

    # render a partial?
  end
end 
