class AddNextJobToCode < ActiveRecord::Migration
  def change
    add_column :codes, :next_job, :string
  end
end
