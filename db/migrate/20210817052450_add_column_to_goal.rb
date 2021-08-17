class AddColumnToGoal < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :row_order, :integer
  end
end
