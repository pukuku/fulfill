class GoalsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @goals = Goal.where(user_id: current_user.id).page(params[:page]).per(10)
    @clips = Clip.where(user_id: current_user.id).page(params[:page]).per(20)
  end

  def show
    @goal = Goal.find(params[:id])
    @task_works = TaskWork.where(goal_id: @goal.id)
    @report = Report.new
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    if @goal.save
      redirect_to goal_path(@goal.id)
    else
      render 'new'
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    @tasks = Task.where(goal_id: @goal.id)
    @tasks_week = [
    @tasks_sun = Task.where(goal_id: @goal.id, sun: "1"),
    @tasks_mon = Task.where(goal_id: @goal.id, mon: "1"),
    @tasks_tue = Task.where(goal_id: @goal.id, tue: "1"),
    @tasks_wed = Task.where(goal_id: @goal.id, wed: "1"),
    @tasks_thu = Task.where(goal_id: @goal.id, thu: "1"),
    @tasks_fri = Task.where(goal_id: @goal.id, fri: "1"),
    @tasks_sat = Task.where(goal_id: @goal.id, sat: "1")
    ]
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update(goal_params)
  end

  def destroy
    @goal=Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_path
  end

  def init
    @goal = Goal.new
  end

  def init_create
    @goal = current_user.goals.build(goal_params)
    if @goal.save
      redirect_to goals_path
    else
      render 'init'
    end
  end

  def copy
    # コピー対象
    @copy = Goal.find(params[:id])
    @tasks = Task.where(goal_id: params[:id])
    # 目標コピー
    @goal = Goal.new(user_id: current_user.id, content: @copy.content)
    @goal.save
    # タスクコピー
    @tasks.each do |task|
      @task = Task.new(goal_id: @goal.id, content: task.content,
                       sun: task.sun, mon: task.mon, tue: task.tue, wed: task.wed, thu: task.thu, fri: task.fri, sat: task.sat)
      @task.save
      @task.task_work_create
    end
    redirect_to goal_path(@goal.id)
  end

private

  def goal_params
    params.require(:goal).permit(:content)
  end

end