ActiveAdmin.register_page "My Label" do
  menu :label => 'My Label', :if => proc { current_user.reseller? }

  content do
    div(:id => 'main_content') do
      labelObj = current_user.label
      if params[:label_id]
        labelObj = Label.find(params[:label_id])
      end
      form(:action => "/admin/labels/#{labelObj.id}/plow", :method => 'post', :class => 'formtastic label', :id => 'label_form_xyzzy', :enctype => "multipart/form-data") do
        form_authenticity_token
        fieldset(:class => 'inputs') do
          input(:name => "authenticity_token", :value => form_authenticity_token, :type => "hidden")
          ol do
            li(:class => 'string input optional stringish') do
              label(:for => 'label_theme') do
                'Theme'
              end
              select :id => 'label_theme', :type => 'text', 'name' => 'label[theme]' do
                option ''
                Label::THEMES.each do |t|
                  if t.downcase==labelObj.theme
                    option t.humanize, :value=>t, :selected=>'selected'
                  else
                    option t.humanize, :value=>t
                  end
                end
              end
            end
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
              label(:for => 'label_mail_from') do
                'Mail From'
              end
              input(:id => 'label_mail_from', :type => 'text', 'name' => 'label[mail_from]', 'value' => labelObj.mail_from)
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
              label(:for => 'label_footer') do
                'Footer HTML'
              end
              textarea(:id => "label_footer", :name => "label[footer]", :rows => "20") do
                labelObj.footer
              end
            end
            if labelObj.logo
              li(:class => 'input optional') do
                image_tag(labelObj.logo.url(:thumb))
              end
            end
            li(:class => 'string input optional stringish') do
              label(:for => 'label_logo') do
                'Logo'
              end
              input(:id => 'label_logo', :type => 'file', 'name' => 'label[logo]')
            end
            li(:class => 'string input optional stringish', :style => "margin-bottom: 30px;") do
              label(:for => 'label_logo') do
                'PDF or Excel Report'
              end
              label(:for => 'label_password', :class => "checkbox toggle candy", :style => "width:37%;") do
                if labelObj.is_pdf?
                  input(:id => 'label_is_pdf', :checked => 'checked', :type => 'checkbox', 'name' => 'label[is_pdf]')
                else
                  input(:id => 'label_is_pdf', :type => 'checkbox', 'name' => 'label[is_pdf]')
                end
                para('') do
                  span "PDF"
                  span "Excel"
                end
                a(:class => "slide-button")
              end
            end

            li(:class => 'string input optional stringish') do
              label(:for => 'label_logo') do
                'Password show/hide reseller'
              end
              label(:for => 'label_password', :class => "checkbox toggle candy", :style => "width:37%;") do
                if labelObj.is_show_password?
                  input(:id => 'label_is_show_password', :checked => 'checked', :type => 'checkbox', 'name' => 'label[is_show_password]')
                else
                  input(:id => 'label_is_show_password', :type => 'checkbox', 'name' => 'label[is_show_password]')
                end
                para('') do
                  span "show"
                  span "hide"
                end
                a(:class => "slide-button")
              end
            end

            #li(:class => 'string input optional stringish') do
            #  label(:for => 'label_logo') do
            #    'Password show/hide reseller'
            #  end
            #  label(:for => 'label_password', :class => "checkbox toggle candy", :style => "width:37%;") do
            #    if labelObj.is_show_password?
            #      input(:id => 'label_is_show_password', :checked => 'checked', :type => 'checkbox', 'name' => 'label[is_show_password]')
            #    else
            #      input(:id => 'label_is_show_password', :type => 'checkbox', 'name' => 'label[is_show_password]')
            #    end
            #    para('') do
            #      span "show"
            #      span "hide"
            #    end
            #    a(:class => "slide-button")
            #  end
            #end

          end

        end
        fieldset(:class => "actions", :style => "margin-top: 10px;") do
          ol do
            li(:class => "action input_action", :id => "label_submit_action", :style => "clear:both;") do
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

