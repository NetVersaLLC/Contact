class AddAttachmentDataToScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.attachment :data
    end
    add_column :jobs, :screenshot_id, :integer
  end
end
