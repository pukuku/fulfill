class TaskWork < ApplicationRecord
  with_options presence: true do
    validates :goal_id
    validates :task_id
  end

  validates :status, inclusion: { in: [true, false] }

  belongs_to :goal
  belongs_to :task

  # 追加メソッド
  # タスクワーク作成
  def self.task_work_create(task)
    is_true = true
    TaskWork.transaction(joinable: false, requires_new: true) do
      day = task.updated_at.wday
      checked = [task.sun,task.mon,task.tue,task.wed,task.thu,task.fri,task.sat]
      if checked[day] == "1"
        if !task_work = TaskWork.find_by(goal_id: task.goal_id, task_id: task.id)
          task_work = TaskWork.new(goal_id: task.goal_id, task_id: task.id)
          is_true &= task_work.save
        end
      end
      unless is_true
        raise ActiveRecord::Rollback
      end
    end
    is_true
  end

  # タスクワーク削除
  def self.task_work_destroy(task)
    is_true = true
    TaskWork.transaction(joinable: false, requires_new: true) do
      day = task.updated_at.wday
      checked = [task.sun,task.mon,task.tue,task.wed,task.thu,task.fri,task.sat]
      if checked[day] == "0"
        if task_work = TaskWork.find_by(goal_id: task.goal_id, task_id: task.id)
          is_true &= task_work.destroy
        end
      end
      unless is_true
        raise ActiveRecord::Rollback
      end
    end
    is_true
  end

end
