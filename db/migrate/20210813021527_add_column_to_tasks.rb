class AddColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :sun, :string, null: false, default: "0"
    add_column :tasks, :mon, :string, null: false, default: "0"
    add_column :tasks, :tue, :string, null: false, default: "0"
    add_column :tasks, :wed, :string, null: false, default: "0"
    add_column :tasks, :thu, :string, null: false, default: "0"
    add_column :tasks, :fri, :string, null: false, default: "0"
    add_column :tasks, :sat, :string, null: false, default: "0"
  end
end
