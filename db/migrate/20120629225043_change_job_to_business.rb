class ChangeJobToBusiness < ActiveRecord::Migration
  def change
    rename_column :jobs, :user_id, :business_id
  end
end
