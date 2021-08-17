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

  def task_work_destroy
    day = self.updated_at.wday
    checked = [self.sun,self.mon,self.tue,self.wed,self.thu,self.fri,self.sat]
    if checked[day] == "0"
      if task_work = TaskWork.find_by(goal_id: self.goal_id, task_id: self.id)
        task_work.destroy
      end
    end
  end

end