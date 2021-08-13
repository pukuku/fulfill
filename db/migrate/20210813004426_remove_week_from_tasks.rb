class RemoveWeekFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :week, :integer
  end
end
