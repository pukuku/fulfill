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

end