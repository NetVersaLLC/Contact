ActiveAdmin.register_page "My Label" do
  menu :label => 'My Label', :if => proc{ current_user.reseller? }

  content do
    div(:id => 'main_content') do
      labelObj = current_user.label
      form(:action => "/admin/labels/#{labelObj.id}/plow", :method => 'post', :class => 'formtastic label', :id => 'label_form_xyzzy', :enctype => "multipart/form-data") do
        fieldset(:class => 'inputs') do
          ol do
            li(:class => 'string input optional stringish') do
              label(:for => 'label_name') do
                'Name'
              end
              input(:id => 'label_name', :type => 'text', 'name' => 'label[name]', 'value' => labelObj.name)
            end
            li(:class => 'string input optional stringish') do
              label(:for => 'label_domain') do
                'Domain'
              end
              input(:id => 'label_domain', :type => 'text', 'name' => 'label[domain]', 'value' => labelObj.domain)
            end
            li(:class => 'string input optional stringish') do
              label(:for => 'label_login') do
                'Authorize.net Login'
              end
              input(:id => 'label_login', :type => 'text', 'name' => 'label[login]', 'value' => labelObj.login)
            end
            li(:class => 'string input optional stringish') do
              label(:for => 'label_password') do
                'Authorize.net Password'
              end
              input(:id => 'label_password', :type => 'text', 'name' => 'label[password]', 'value' => labelObj.password)
            end
            li(:class => 'string input optional stringish') do
              label(:for => 'label_custom_css') do
                'Custom CSS'
              end
              textarea(:id => "label_custom_css", :name => "label[custom_css]", :rows => "20") do
                labelObj.custom_css
              end
            end
            li(:class => 'string input optional stringish') do
              label(:for => 'label_logo') do
                'Logo'
              end
              if labelObj.logo
                image_tag(labelObj.logo.url(:thumb))
              end
              input(:id => 'label_logo', :type => 'file', 'name' => 'label[logo]')
            end
          end
          fieldset(:class => "actions") do
            ol do
              li(:class => "action input_action", :id=>"label_submit_action") do
                input(:name => "commit", :type => "submit", :value => "Update Label")
              end
              li(:class => "cancel") do
                link_to 'Cancel', "/admin/labels"
              end
            end
          end
        end
      end
    end
  end
end
