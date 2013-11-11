class CreateReportFeedbacks < ActiveRecord::Migration
  def change
    create_table :report_feedbacks do |t|
      t.integer :report_id
      t.text :message

      t.timestamps
    end
  end
end
