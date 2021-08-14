class Batch::TaskWork
  def self.task_work

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

    tasks.each do |task|
      TaskWork.new
      TaskWork.goal_id = task.goal_id
      TaskWork.task_id = task.id
      TaskWork.save
    end

    p "ワークファイルを作成しました"

  end
end


