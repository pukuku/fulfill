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

  # ranked_model導入
  include RankedModel
  ranks :row_order , with_same: :user_id

  # fulness取得
  def month_fulness
    day = Time.now.day
    fulness = Report.where(goal_id: self.id).sum(:fulness)
    monthly = fulness / day
    return monthly
  end

  def week_fulness
    fulness = Report.where(goal_id: self.id).sum(:fulness)
    day = Time.now.day
    wday = Time.now.wday
    # 1週間の中で月をまたぐ場合は月初から今日までを表示する
    if wday > day
      return monthly = fulness / day
    else
      return weekly = fulness / wday
    end
  end

  # progress取得
  def sum_progress
    # レポート全件取得
    all = Report.where(goal_id: self.id).sum(:task_all)
    progress = Report.where(goal_id: self.id).sum(:task_progress)
  # ZeroDivisionError の例外処理
    begin
      pct = (progress.to_f / all) * 100
    rescue
      pct=0
    end
    pct = pct.to_s(:rounded, precision: 1)
    return pct
  end

  # シェア一覧検索用スコープ
  # コンテントにキーワードが入ったものを抽出
  scope :share_word, -> (word) { where(["goals.content like?","%#{word}%"])}
  # ステータスが達成のもののみ抽出
  scope :share_status, -> { where(status: true) }

end