class Task < ApplicationRecord

  with_options presence: true do
    validates :goal_id
    validates :sun
    validates :mon
    validates :tue
    validates :wed
    validates :thu
    validates :fri
    validates :sat
    validates :content
  end

  belongs_to :goal
  has_one :task_work, dependent: :destroy

  # 追加メソッド
  # 1週間のタスクを取得
  def self.tasks_week(goal_id)
    tasks_week = []
    weeks = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    weeks.each do |week|
      tasks_week.push(Task.where(goal_id: goal_id, "#{week}": "1"))
    end
    tasks_week
  end

  # タスクコピー
  def self.record_copy(goal, tasks, current_user)
    is_true = true
    Task.transaction(joinable: false, requires_new: true) do
      is_true &= goal.goal_record_add(current_user)
      tasks.each do |task|
      new_task = Task.new(goal_id: goal.id, content: task.content,
                       sun: task.sun, mon: task.mon, tue: task.tue, wed: task.wed, thu: task.thu, fri: task.fri, sat: task.sat)
      is_true &= new_task.save
      is_true &= TaskWork.task_work_create(new_task)
      end
      unless is_true
        raise ActiveRecord::Rollback
      end
    end
    is_true
  end

  # タスク追加
  def task_record_add
    is_true = true
    Task.transaction(joinable: false, requires_new: true) do
      is_true &= self.save
      is_true &= TaskWork.task_work_create(self)
      unless is_true
        raise ActiveRecord::Rollback
      end
    end
    is_true
  end

  # タスク編集
  def task_record_update(task_params)
    is_true = true
    Task.transaction(joinable: false, requires_new: true) do
      is_true &= self.update(task_params)
      is_true &= TaskWork.task_work_create(self)
      is_true &= TaskWork.task_work_destroy(self)
      unless is_true
        raise ActiveRecord::Rollback
      end
    end
    is_true
  end

  # タスク削除
  def task_record_destroy
    is_true = true
    Task.transaction(joinable: false, requires_new: true) do
      is_true &= self.destroy
      is_true &= TaskWork.task_work_destroy(self)
      unless is_true
        raise ActiveRecord::Rollback
      end
    end
    is_true
  end

end