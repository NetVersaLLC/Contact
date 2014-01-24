class CreateCostCenters < ActiveRecord::Migration
  def up
    create_table :cost_centers do |t|
      t.string :name
      t.references :label
    end 
  end

  def down
    drop_table :cost_centers
  end
end
