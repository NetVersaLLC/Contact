class SetCallcenteridOnBusinesses < ActiveRecord::Migration
  def up
    execute <<-SQL 
      update businesses 
        inner join users sales on businesses.sales_person_id = sales.id 
        inner join users managers on sales.manager_id = managers.id 
        set businesses.call_center_id = managers.call_center_id;
    SQL
  end

  def down
  end
end
