class AddEmailToDigabusiness < ActiveRecord::Migration
  def change
    add_column :digabusinesses, :email, :string
  end
end
