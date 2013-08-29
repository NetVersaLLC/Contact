ActiveAdmin.register_page "My Label" do
  menu :label => "My Label", :if => proc { current_user.reseller? }

  content do
    semantic_form_for current_user.label, url: plow_admin_label_path(current_user.label), :builder => ActiveAdmin::FormBuilder do |f|
      f.semantic_errors
      f.inputs do
        f.input :theme, as: :select, :collection => Hash[ Label::THEMES.map{|t| [t.humanize, t]}]
        f.input :name
        f.input :legal_name
        f.input :domain 
        f.input :label_domain 
        f.input :address
        f.input :support_phone
        f.input :support_email
        f.input :mail_from
        f.input :logo, :as => :file 
        f.input :favicon, :as => :file
        f.input :login, :label => 'Authorize.Net Login'
        f.input :password, :label => 'Authroize.Net Password'
        f.input :report_email_body
        f.input :custom_css # text area 
        f.input :footer # text area
        f.input :is_pdf, :as => :radio, :collection => { "PDF" => true, "CSV" => false} 
        f.input :is_show_password, :as => :radio, :collection => { "Show" => true, "Hide" => false} 
      end

      f.actions 
    end 
  end 
end

