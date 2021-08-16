class Goal < ApplicationRecord

  with_options presence: true do
    validates :user_id
    validates :content
  end

  validates :status,inclusion: { in: [true,false]}

  has_many :tasks,dependent: :destroy
  has_many :task_works, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :user
  has_one :share, dependent: :destroy

  acts_as_list scope: :user

def sum_fulness
    reports = Report.where(goal_id: self.id)
    sum = 0
    reports.each do |report|
      sum += report.fulness
    end
    return sum
end

def sum_progress
    reports = Report.where(goal_id: self.id)
    progress = 0.0
    all = 0.0
    pct = 0.0
    reports.each do |report|
      progress += report.task_progress.to_f
      all += report.task_all.to_f
    end
    pct = (progress / all) * 100
    return pct
end




# コンテントにキーワードが入ったものを抽出
scope :share_word, -> (word) { where(["goals.content like?","%#{word}%"])}
# ステータスが達成のもののみ抽出
scope :share_status, -> { where(status: true) }

end