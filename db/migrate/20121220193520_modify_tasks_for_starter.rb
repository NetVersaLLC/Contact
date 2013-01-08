class ModifyTasksForStarter < ActiveRecord::Migration
  def change
    rename_column :tasks, :user_id,    :business_id
    remove_column :tasks, :name
    add_column    :tasks, :started_at, :datetime
  end
end
