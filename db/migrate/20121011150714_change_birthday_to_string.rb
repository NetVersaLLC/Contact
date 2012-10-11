class ChangeBirthdayToString < ActiveRecord::Migration
  def change
    change_column :businesses, :contact_birthday, :string
    change_column :jobs, :data_generator, :text
  end
end
