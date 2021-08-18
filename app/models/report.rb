class Report < ApplicationRecord

  with_options presence: true do
    validates :goal_id
    validates :comment
    validates :fulness
    validates :task_all
    validates :task_progress
  end

  belongs_to :goal

end