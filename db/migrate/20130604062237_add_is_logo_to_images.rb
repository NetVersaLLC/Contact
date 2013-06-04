class AddIsLogoToImages < ActiveRecord::Migration
  def change
    add_column :images, :is_logo, :boolean
  end
end
