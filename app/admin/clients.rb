ActiveAdmin.register_page "Client Manager" do
  menu false

  sidebar :payloads do
    div({:id => 'payload_list'}) do
      ""
    end
  end

  content do
    div(:id => 'assign_payload', :style => 'display: none') do
      h2 "Assign payload?"
      para "Are you sure you want to assign payload to client?"
    end
    div(:id => 'delete_job', :style => 'display: none') do
      h2 "Delete job?"
      para "Are you sure you want to delete this job?"
    end
    div(:id => 'rerun_payload', :style => 'display: none') do
      h2 "Re-run job?"
      para "Are you sure you want to add this job back to the queue?"
    end
    div(:id => 'view_payload', :style => 'display: none') do
      ""
    end
    div(:id => 'view_meta', :style => 'display: none') do
      ""
    end
    div(:id => 'view_booboo', :style => 'display: none') do
      ""
    end
    script do
      raw "window.business_id = #{params[:business_id]};\n" +
      "window.payloadListAction = window.clientPayloadListAction;\n"+
      "$(document).ready(function() { window.startPayloads(); });"
    end
    div(:id => 'client_info') do
      @business_info = Business.find(params[:business_id])
      h3 @business_info.business_name + '/' + @business_info.address + '/' + @business_info.local_phone
    end
    div(:id => 'client_tabs') do
      ul(:id => 'client_tabs_top') do
        li span(:class => 'ui-icon ui-icon-carat-2-n-s') + link_to("Pending",     "#client_tabs-1")
        li span(:class => 'ui-icon ui-icon-alert') + link_to("Failed",      "#client_tabs-2")
        li span(:class => 'ui-icon ui-icon-circle-check') + link_to("Succeeded",   "#client_tabs-3")
        li span(:class => 'ui-icon ui-icon-circle-close') + link_to("Errors",      "#client_tabs-4")
        li span(:class => 'ui-icon ui-icon-info') + link_to("Client Info", "#client_tabs-5")
      end
      div(:id => 'client_tabs-1') do
        ""
      end
      div(:id => 'client_tabs-2') do
        ""
      end
      div(:id => 'client_tabs-3') do
        ""
      end
      div(:id => 'client_tabs-4') do
        ""
      end
      div(:id => 'client_tabs-5') do
        ""
      end
    end
  end

  action_item do
    link_to "Reload View", "#", :id => 'reloadButton'
  end

end
