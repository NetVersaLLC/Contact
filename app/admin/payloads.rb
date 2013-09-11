ActiveAdmin.register_page "Payloads" do
  admin_sub_menu

  sidebar 'Payload Errors' do
    div({:id => 'payload_error_menu'}) do
      ""
    end
  end

  content do
    div({:id => 'payload_error_content'}) do
      h1 do
        "Payload Errbit COMING SOON"
      end
    end
  end

end
