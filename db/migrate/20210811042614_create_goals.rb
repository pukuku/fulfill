class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :content, null: false
      t.boolean :status, null: false, default: false

      t.timestamps
    end
  end
end