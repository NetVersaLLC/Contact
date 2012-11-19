class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string   :name
      t.string   :domain
      t.string   :logo_file_name
      t.string   :logo_content_type
      t.integer  :logo_file_size
      t.datetime :logo_updated_at
      t.text     :custom_css
      t.timestamps
    end
    add_index  :labels,      :domain
    add_column :admin_users, :label_id, :integer
    add_index  :admin_users, :label_id
    add_column :users,       :label_id, :integer
    add_index  :users,       :label_id
    Label.create do |c|
      c.name   = 'TownCenter'
      c.domain = 'towncenter.com'
    end
  end
end
