class TasksController < ApplicationController
  def new
    @task=Task.new
    @goal = Goal.find(params[:goal_id])
  end

  def create
    @task = Task.new(task_params)
    @task.goal_id = params[:goal_id]
    if @task.save
      # 今日の曜日ならタスクワークを更新
      @task.task_work_create
      @goal = Goal.new
      @tasks = Task.where(goal_id: params[:goal_id])
      redirect_to edit_goal_path(@task.goal_id)
    else
    @goal = Goal.find(params[:goal_id])
    end

  end

  def edit
    @task=Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      # 今日の曜日ならタスクワークを更新
      @task.task_work_create
      @task.task_work_destroy
      @goal = Goal.find(@task.goal_id)
      @tasks = Task.where(goal_id: @task.goal_id)
      redirect_to edit_goal_path(@task.goal_id)
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      # 今日の曜日ならタスクワークを更新
      @task.task_work_destroy
      redirect_to edit_goal_path(@task.goal_id)
    end
  end

  private

  def task_params
    params.require(:task).permit(:content, :sun, :mon, :tue, :wed, :thu, :fri, :sat)
  end

end
