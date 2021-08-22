class GoalsController < ApplicationController
  after_action :reset_row_order, only: [:sort, :create]
  before_action :user_info

  def index
    @goals = current_user.goals.rank(:row_order).where(status:false)
    @completes = current_user.goals.rank(:row_order).where(status:true)
  end

  def sort
    goal= Goal.find(params[:id])
    goal.update(rank_params)
    render body: nil
  end

  def show
    @goal = Goal.find(params[:id])
    # アクセス権
    @correct_user = User.find(@goal.user_id)
    if @correct_user != current_user
      redirect_to goals_path
    end
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
    @user = User.find(current_user.id)
    @clips = Clip.where(user_id: current_user.id).page(params[:page]).per(10)
    @goal = Goal.find(params[:id])
    # アクセス権
    @correct_user = User.find(@goal.user_id)
    if @correct_user != current_user
      redirect_to goals_path
    end
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
    # アクセス権
    @correct_user = User.find(@goal.user_id)
    if @correct_user != current_user
      redirect_to goals_path
    end
    @goal.update(goal_params)
  end

  def destroy
    @goal=Goal.find(params[:id])
    # アクセス権
    @correct_user = User.find(@goal.user_id)
    if @correct_user != current_user
      redirect_to goals_path
    end
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

  def reset_row_order
    @goals = current_user.goals.rank(:row_order).where(status:false)
    @goals.each_with_index do |goal, i|
      goal.update_attribute :row_order, i + 1
    end
    @count = @goals.count
    @completes = current_user.goals.rank(:row_order).where(status:true)
    @completes.each_with_index do |goal, i|
      goal.update_attribute :row_order, @count + i + 1
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