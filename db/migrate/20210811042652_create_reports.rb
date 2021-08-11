class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :goal_id, null: false
      t.string :comment, null: false
      t.float :fulness, null: false
      t.integer :task_all, null: false
      t.integer :task_progress, null: false

      t.timestamps
    end
  end
end