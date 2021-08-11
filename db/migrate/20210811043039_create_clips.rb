class CreateClips < ActiveRecord::Migration[5.2]
  def change
    create_table :clips do |t|
      t.integer :user_id, null: false
      t.integer :share_id, null: false

      t.timestamps
    end
  end
end