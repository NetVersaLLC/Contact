class AddSecretsToMagicyellow < ActiveRecord::Migration
  def change
    add_column :magicyellows, :secrets, :text
  end
end
