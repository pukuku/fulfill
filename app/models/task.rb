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

  # タスクワーク作成
  def task_work_create
    day = self.updated_at.wday
    checked = [self.sun,self.mon,self.tue,self.wed,self.thu,self.fri,self.sat]
    if checked[day] == "1"
      if !task_work = TaskWork.find_by(goal_id: self.goal_id, task_id: self.id)
        task_work = TaskWork.new(goal_id: self.goal_id, task_id: self.id)
        task_work.save
      end
    end
  end

  # タスクワーク削除
  def task_work_destroy
    day = self.updated_at.wday
    checked = [self.sun,self.mon,self.tue,self.wed,self.thu,self.fri,self.sat]
    if checked[day] == "0"
      if task_work = TaskWork.find_by(goal_id: self.goal_id, task_id: self.id)
        task_work.destroy
      end
    end
  end

  # 1週間のタスクを取得
  def self.tasks_week(goal_id)
    tasks_week = []
    weeks = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    weeks.each do |week|
      tasks_week.push(Task.where(goal_id: goal_id, "#{week}": "1"))
    end
    tasks_week
  end

end