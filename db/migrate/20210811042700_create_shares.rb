class CreateShares < ActiveRecord::Migration[5.2]
  def change
    create_table :shares do |t|
      t.integer :user_id, null: false
      t.integer :goal_id, null: false
      t.integer :category_id, null: false
      t.string :content, null: false
      t.integer :copy_count, null: false, default: 0

      t.timestamps
    end
  end
end