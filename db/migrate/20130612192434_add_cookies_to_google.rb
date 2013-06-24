class AddCookiesToGoogle < ActiveRecord::Migration
  def change
    add_column :googles, :cookies, :text
  end
end
