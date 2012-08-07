ActiveAdmin.register GoogleCategory do
  index do
    column :name
    column :category do |v|
      raw "<ul id='cat#{v.id}' class='categoryPicker'>" + YelpCategory.build_menu + "</ul>"
    end
  end
end
