class Task < ApplicationRecord

  with_options presence: true do
    validates :goal_id
    validates :week
    validates :content
  end

  enum week: { 日曜日: 0, 月曜日: 1, 火曜日: 2, 水曜日: 3, 木曜日: 4, 金曜日: 5, 土曜日: 6 }

  belongs_to :goal
  has_one :task_work, dependent: :destroy

end