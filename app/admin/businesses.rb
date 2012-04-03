ActiveAdmin.register Business do
  index do
    column :name
    column :website do |v|
      link_to v.website, v.website
    end
    column :approved
    default_actions
  end

  form do |f|
    f.inputs "Business Details" do
      f.input :name, :label => 'Business Name'
      f.input :contact, :label => 'Company Contact'
      f.input :phone
      f.input :alternate_phone
      f.input :fax
      f.input :address
      f.input :address2
      f.input :city
      f.input :state
      f.input :zip
      f.input :website
      f.input :email
    end
    f.inputs "Mail" do
      f.input :mail_host
      f.input :mail_port
      f.input :mail_username
      f.input :mail_password
    end
    f.inputs "Yelp" do
      f.input :yelp_category_id, :as => :select, :collection => YelpCategory.list
    end
    f.inputs "Approve" do
      f.input :approved
    end
    f.buttons
  end

end
