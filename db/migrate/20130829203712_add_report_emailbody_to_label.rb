class AddReportEmailbodyToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :report_email_body, :text
  end
end
