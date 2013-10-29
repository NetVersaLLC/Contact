ActiveAdmin.register Report do
  menu :label => 'Leads'

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
    actions
  end
end 
