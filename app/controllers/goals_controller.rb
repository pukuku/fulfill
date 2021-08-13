class GoalsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @goals = Goal.where(user_id: current_user.id).page(params[:page]).per(10)
    @clips = Clip.where(user_id: current_user.id).page(params[:page]).per(20)
  end

  def show
    @goal = Goal.find(params[:id])
    if params[:search]
      @task=Task.find(params[:search])
    else
      @task =Task.new
    end
    @tasks = Task.where(goal_id: @goal.id)
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
    @tasks_sun = Task.where(sun: "1"),
    @tasks_mon = Task.where(mon: "1"),
    @tasks_tue = Task.where(tue: "1"),
    @tasks_wed = Task.where(wed: "1"),
    @tasks_thu = Task.where(thu: "1"),
    @tasks_fri = Task.where(fri: "1"),
    @tasks_sat = Task.where(sat: "1")
    ]
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
    else
    end
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


  private

  def goal_params
    params.require(:goal).permit(:content)
  end

end