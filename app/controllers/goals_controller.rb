class GoalsController < ApplicationController
  before_action :user_info

  def index
    @goals = current_user.goals.rank(:row_order).where(status: false)
    @completes = current_user.goals.rank(:row_order).where(status: true)
  end

  def sort
    goal = Goal.find(params[:id])
    goal.goal_record_sort(rank_params,current_user)
  end

  def show
    @goal = Goal.find(params[:id])
    user_check(@goal.user_id)
    @task_works = TaskWork.where(goal_id: @goal.id)
    @report = Report.new
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    if @goal.goal_record_add(current_user)
      redirect_to goal_path(@goal.id)
    else
      render "new"
    end
  end

  def edit
    @user = User.find(current_user.id)
    @clips = Clip.where(user_id: current_user.id).page(params[:page]).per(10)
    @goal = Goal.find(params[:id])
    user_check(@goal.user_id)
    @tasks = Task.where(goal_id: @goal.id)
    @tasks_week = Task.tasks_week(@goal.id)
  end

  def update
    @goal = Goal.find(params[:id])
    user_check(@goal.user_id)
    @goal.update(goal_params)
  end

  def destroy
    goal = Goal.find(params[:id])
    user_check(goal.user_id)
    goal.destroy
    flash[:notice] = "削除しました"
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
      render "init"
    end
  end

  def copy
    # コピー対象
    @copy = Goal.find(params[:id])
    @tasks = Task.where(goal_id: params[:id])
    # 目標コピー
    @goal = Goal.new(user_id: current_user.id, content: @copy.content)
    if Task.record_copy(@goal,@tasks,current_user)
      flash[:notice] = "コピーしました"
      redirect_to goal_path(@goal.id)
    else
      flash[:notice] = "コピーできませんでした"
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:content, :row_order_position)
  end

  def rank_params
    params.permit(:status, :row_order_position)
  end
end
