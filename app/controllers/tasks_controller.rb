class TasksController < ApplicationController
  before_action :user_info

  def new
    @task = Task.new
    @goal = Goal.find(params[:goal_id])
  end

  def create
    @task = Task.new(task_params)
    @task.goal_id = params[:goal_id]
    @goal = Goal.find(params[:goal_id])
    @tasks = Task.where(goal_id: params[:goal_id])
    if @task.task_record_add
      redirect_to edit_goal_path(@task.goal_id)
    else
      flash[:notice] = "作成できませんでした"
    end
  end

  def edit
    @goal = Goal.find(params[:goal_id])
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @goal = Goal.find(@task.goal_id)
    @tasks = Task.where(goal_id: @task.goal_id)
    if @task.task_record_update(task_params)
      redirect_to edit_goal_path(@task.goal_id)
    else
      flash[:notice] = "変更できませんでした"
    end
  end

  def destroy
    task = Task.find(params[:id])
    if task.task_record_destroy
      redirect_to edit_goal_path(task.goal_id)
    else
      flash[:notice] = "削除できませんでした"
    end
  end

  private

  def task_params
    params.require(:task).permit(:content, :sun, :mon, :tue, :wed, :thu, :fri, :sat)
  end
end
