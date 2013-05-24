class AddThemeToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :theme, :string
  end
end
