class PayloadNodesController < ApplicationController
  authorize_resource

  def index
    @payloads = Payload.order('position asc')
  end

  def create
   new_node_ids = {} 
   tree = params[:tree] 
   tree.each_with_index do |leaf, i| 
     n = leaf[1] 

     parent_id = n[:parent_id] == 'root' ? nil : n[:parent_id]
     parent_id = new_node_ids[parent_id] if parent_id.present? && parent_id.starts_with("new")

     if n[:id].starts_with("new")
       node = Payload.create( name: n[:name], parent_id: parent_id, position: i )
       new_node_ids[n[:id]] = node.id 
     else 
       node = Payload.find( n[:id] ) 
       node = node.update_attributes( name: n[:name], parent_id: parent_id, position: i)
     end 
   end
   trash = params[:trash]
   unless trash.nil?
     trash.each do |item| 
       Payload.delete( item[1][:id] )
     end 
   end 
   # take out the trash
    
   render json: { result: 'success'}

  end 
end 
