class PopulatePayloads < ActiveRecord::Migration
  def up
    Payload.sites.each do |site| 
      Payload.list(site).each_with_index do |payload, i|
        PayloadNode.create( site_name: site, payload_name: payload, position: i, parent_id: nil )
      end
    end 
  end

  def down
    PayloadNode.delete_all
  end
end
