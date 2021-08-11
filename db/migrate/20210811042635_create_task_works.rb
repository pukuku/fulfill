class CreateTaskWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :task_works do |t|
      t.integer :goal_id, null: false
      t.integer :task_id, null: false
      t.boolean :status, null: false, default: false

      t.timestamps
    end
  end
end