class PayloadNodesController < ApplicationController
  before_filter      :authenticate_user!

  def index
    if current_user.reseller?
      @payloads = PayloadNode.order('position asc')
      render json: @payloads
    else
      error = {:error => :access_denied}
      render json: error, :status => 403
    end
  end

  def create
   new_node_ids = {} 
   tree = params[:tree] 
   tree.each_with_index do |leaf, i| 
     n = leaf[1] 

     parent_id = n[:parent_id] == 'root' ? nil : n[:parent_id]
     parent_id = new_node_ids[parent_id] if parent_id.present? && parent_id.starts_with("new")

     if n[:id].starts_with("new")
       node = PayloadNode.create( name: n[:name], parent_id: parent_id, position: i )
       new_node_ids[n[:id]] = node.id 
     else 
       node = PayloadNode.find( n[:id] ) 
       node = node.update_attributes( name: n[:name], parent_id: parent_id, position: i)
     end 
   end
   trash = params[:trash]
   unless trash.nil?
     trash.each do |item| 
       PayloadNode.delete( item[1][:id] )
     end 
   end 
   # take out the trash
    
   render json: { result: 'success'}

  end 
end 
