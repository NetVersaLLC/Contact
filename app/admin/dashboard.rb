ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => 'Dashboard'

  content :title => 'Dashboard' do
    panel "Available Balance" do
      h1(number_to_currency(current_user.label.available_balance)) #credits)
      unless current_user.label.parent.nil?
        div "Add funds by calling #{current_user.label.parent.name}" # "Purchase more credits by calling NetVersa"
      end 
    end
    panel "Sub-Resellers By Available Balance" do 
      table_for current_user.label.children.limit(10).order('available_balance') do  #order('credits asc') do
        column :name
        column {|lab| number_to_currency(lab.available_balance) } 
        column "Payment" do |obj|
          link_to "Add Funds", new_admin_credit_event_path( :other_id => obj.id ) 
        end
      end
    end
  end

end
