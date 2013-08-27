class PayloadNodesController < ApplicationController
  before_filter      :authenticate_user!

  def show
    if current_user.reseller?
      @payloads = PayloadNode.list(params[:id])
      render json: @payloads
    else
      error = {:error => :access_denied}
      render json: error, :status => 403
    end
  end

  def create
   site_name = params[:site]
   tree = params[:tree] 
   tree.each_with_index do |leaf, i| 
     n = leaf[1] 
     parent_id = n[:parent_id] == 'root' ? nil : n[:parent_id]
     if n[:id] == "new" 
       node = PayloadNode.create( payload_name: n[:name], site_name: site_name, parent_id: parent_id, position: i )
     else 
       node = PayloadNode.find( n[:id] ) 
       node = node.update_attributes( payload_name: n[:name], parent_id: parent_id, position: i)
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
