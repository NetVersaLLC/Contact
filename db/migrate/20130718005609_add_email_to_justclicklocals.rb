class AddEmailToJustclicklocals < ActiveRecord::Migration
  def change
    add_column :justclicklocals, :email, :string
  end
end
