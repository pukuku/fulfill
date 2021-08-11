class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :goal_id, null: false
      t.integer :week, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
