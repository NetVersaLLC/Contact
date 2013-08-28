ActiveAdmin.register_page 'Payload Nodes' do


  content do
    div(:id => 'payload_nodes_container') do
      ""
    end 
    script do
      raw "$(document).ready(function() { window.loadPayloadNodes(); });"
    end
  end 

  action_item do
    link_to "Reload View", "#", :id => 'reloadButton'
  end
end
