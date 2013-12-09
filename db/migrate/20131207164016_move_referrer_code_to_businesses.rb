class MoveReferrerCodeToBusinesses < ActiveRecord::Migration
  def up
    add_column :businesses, :referrer_code, :string

    execute <<-SQL 
      update businesses inner join users on businesses.user_id = users.id set businesses.referrer_code = users.referrer_code 
    SQL
  end

  def down
    remove_column :businesses, :referrer_code
  end
end
