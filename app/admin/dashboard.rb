ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => 'Dashboard'

  content :title => 'Dashboard' do
    panel "My Credits" do
      h1(current_label.credits)
      div "Purchase more credits by calling NetVersa"
    end
    panel "Sub-Resellers By Credits" do
      table_for current_label.children.limit(10).order('credits asc') do
        column :name
        column :credits
        column "Payment" do |obj|
          link_to "Add Credits", '/purchase'
        end
      end
    end
  end
end

