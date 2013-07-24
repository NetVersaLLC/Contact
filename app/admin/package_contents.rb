ActiveAdmin.register_page "Package Contents" do
  menu :label => 'Package Contents'

  sidebar :payloads do
    div({:id => 'payload_list'}) do
      ""
    end
  end

  content do
    para do 
      "Simply drag and drop to change the order for inserting payloads into the queue.  Don't forget to Save Sequence when you are done."
    end 
    select(:id => 'packages_list') do
      current_user.packages.each do |pac|
        option(:value => pac.id) do
          pac.name
        end
      end
    end
    button(:id => 'save_insert_order') do 
      "Save Sequence"
    end 

    pac = current_user.packages.first
    table(:id => 'package_content_table', :class => 'index_table index striped') do
    # gets loaded up via ajax
    #  PackagePayload.where(:package_id => pac.id).order("site asc").each do |obj|
    #    tr 
    #      td(:class => 'payload_name') do 
    #        "#{obj.site}/#{obj.payload}"
    #      end
    #      td(:class => 'payload_delete', 'data-package-id' => obj.id) do
    #        "Delete"
    #      end
    #    end
    #  end
    end
    div(:id => 'assign_payload', :style => 'display: none') do
      h2 "Assign payload?"
      para "Are you sure you want to assign payload to package?"
    end
     script do
      "window.business_id = #{params[:business_id]};" 
    #  "$(document).ready(function() { window.startPayloads(); });"
     end
  end

  action_item do
    link_to "Reload View", "#", :id => 'reloadButton'
  end

end
