class AddFieldsToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :is_pdf, :boolean
    add_column :labels, :is_show_password, :boolean ,:default => true
  end
end
