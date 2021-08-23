class Batch::Daily
  def self.daily

    # 締まっていないレポートのみ空レポート作成
    goals = Goal.left_joins(:reports).select("goals.*").where("reports.id is null")
    success = 0
    error = 0
    goals.each do |goal|
      report = Report.new
      report.goal_id = goal.id
      report.comment = "コメント未送信のためデータなし"
      report.fulness = 0
      report.task_all = TaskWork.where(goal_id: goal.id).count
      report.task_progress = TaskWork.where(goal_id: goal.id,status: true).count
      report.post_date = Time.now - (60)
      if report.save
        success += 1
      else
        error += 1
      end
    end
    p "#{success}件のレポートを作成しました"
    p "エラーは#{error}件です"

    # ワークファイルをリセット
    TaskWork.delete_all

    # 今日の曜日を取得
    require "date"
    day = Date.today.wday
    days = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]

    if days[day] == "sun"
      tasks = Task.where(sun: "1")
    elsif days[day] == "mon"
      tasks = Task.where(mon: "1")
    elsif days[day] == "tue"
      tasks = Task.where(tue: "1")
    elsif days[day] == "wed"
      tasks = Task.where(wed: "1")
    elsif days[day] == "thu"
      tasks = Task.where(thu: "1")
    elsif days[day] == "fri"
      tasks = Task.where(fri: "1")
    elsif days[day] == "sat"
      tasks = Task.where(sat: "1")
    end

    success = 0
    error = 0
    tasks.each do |task|
      today_task =TaskWork.new
      today_task.goal_id = task.goal_id
      today_task.task_id = task.id
      if today_task.save
        success += 1
      else
        error += 1
      end
    end
    p "#{success}件のタスクを作成しました"
    p "エラーは#{error}件です"

  end
end


