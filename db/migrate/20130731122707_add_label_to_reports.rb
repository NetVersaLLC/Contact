class AddLabelToReports < ActiveRecord::Migration
  def change
    add_column :reports, :label_id, :integer
  end
end
