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

  # 追加メソッド
  # fulness取得
  def month_fulness
    day = Time.now.day
    fulness = (Report.where(goal_id: self.id).sum(:fulness)).to_f
    adjust(fulness,day)
  end

  def week_fulness
    day = Time.now.day
    wday = Time.now.wday
    fulness = (Report.where(goal_id: self.id).sum(:fulness)).to_f
    # 1週間の中で月をまたぐ場合は月初から今日までを表示する
    if wday > day
      adjust(fulness,day)
    else
      adjust(fulness,wday)
    end
  end

  # progress取得
  def sum_progress
    # レポート全件取得
    all = Report.where(goal_id: self.id).sum(:task_all)
    progress = Report.where(goal_id: self.id).sum(:task_progress)
    (adjust(progress,all) *100).round(0)
  end

  # ZeroDivisionError,NaN,Infinity の例外処理
  def adjust(base,div)
    begin
      result = base.to_f / div
      # int型変換でエラーを起こす
      result.to_i
    rescue
      result = 0
    end
    result.ceil(2)
  end

  # ドロップアンドドロップで並べ替え
  def goal_record_sort(rank_params, current_user)
    is_true = true
    Goal.transaction(joinable: false, requires_new: true) do
      is_true &= self.update(rank_params)
      reset_row_order(current_user)
      unless is_true
        raise ActiveRecord::Rollback
      end
    end
    is_true
  end

  # 目標追加
  def goal_record_add(current_user)
    is_true = true
    Goal.transaction(joinable: false, requires_new: true) do
      is_true &= self.save
      reset_row_order(current_user)
      unless is_true
        raise ActiveRecord::Rollback
      end
    end
    is_true
  end

  # ranked_modelの番号を整列する
  def reset_row_order(current_user)
    is_true = true
    Goal.transaction(joinable: false, requires_new: true) do
     goals = current_user.goals.rank(:row_order).where(status: false)
      goals.each_with_index do |goal, i|
        is_true &= goal.update_attribute :row_order, i + 1
      end
      count = goals.count
      completes = current_user.goals.rank(:row_order).where(status: true)
      completes.each_with_index do |goal, i|
        is_true &= goal.update_attribute :row_order, count + i + 1
      end
      unless is_true
        raise ActiveRecord::Rollback
      end
    end
    is_true
  end

  # シェア一覧検索用スコープ
  # コンテントにキーワードが入ったものを抽出
  scope :share_word, -> (word) { where(["goals.content like?","%#{word}%"])}
  # ステータスが達成のもののみ抽出
  scope :share_status, -> { where(status: true) }

end