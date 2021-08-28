class TaskWork < ApplicationRecord
  with_options presence: true do
    validates :goal_id
    validates :task_id
  end

  validates :status, inclusion: { in: [true, false] }

  belongs_to :goal
  belongs_to :task
end
