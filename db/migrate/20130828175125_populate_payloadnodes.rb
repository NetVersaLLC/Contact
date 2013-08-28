class PopulatePayloadnodes < ActiveRecord::Migration
  def up
   u = PayloadNode.create( name: "Utils/ImageSync", position: 0, parent_id: nil )
   b = PayloadNode.create( name: "Bing/SignUp", position: 1, parent_id: u.id ) 
    
    Payload.sites.each_with_index do |site, site_index|
      n = b
      Payload.list(site).each_with_index do |payload, i|
        next if site == 'Bing' && payload == "SignUp" 
        n = PayloadNode.create( name: "#{site}/#{payload}", position: site_index * 100 + i + 2, parent_id: n.id )
      end
    end 
  end

  def down
    PayloadNode.delete_all
  end
end
