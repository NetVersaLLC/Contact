ActiveAdmin.register Report do
  menu :label => 'Leads'

  member_action :relaunch, :method => :get do
    report = Report.find(params[:id])
    report.relaunch!
    redirect_to admin_reports_url, {:notice => "Report is being regenerated"}
  end

  action_item :only => :show do
    link_to 'Relaunch', relaunch_admin_report_path(report)
  end

  actions :all, :except => [:edit, :new]


  index as: :table do |report|
    column :business
    column :phone
    column :zip 
    column :created_at
    column :status 
    column do |report|
      link_to "Scan Results", "/scan/#{report.ident}"
    end
    actions do |report|
      link_to 'Relaunch', relaunch_admin_report_path(report), :class => "member_link"
    end
  end
end 
