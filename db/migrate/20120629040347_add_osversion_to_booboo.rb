class AddOsversionToBooboo < ActiveRecord::Migration
  def change
    add_column :booboos, :browser, :string
    add_column :booboos, :osversion, :string
  end
end
