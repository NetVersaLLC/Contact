class AddEmailToTupalo < ActiveRecord::Migration
  def change
    add_column :tupalos, :email, :string
  end
end
