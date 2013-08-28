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
   tree = params[:tree] 
   tree.each_with_index do |leaf, i| 
     n = leaf[1] 
     parent_id = n[:parent_id] == 'root' ? nil : n[:parent_id]
     if n[:id] == "new" 
       node = PayloadNode.create( name: n[:name], parent_id: parent_id, position: i )
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
