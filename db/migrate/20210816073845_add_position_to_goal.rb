class AddPositionToGoal < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :position, :integer
  end
end
