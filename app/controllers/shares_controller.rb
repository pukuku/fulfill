class SharesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @share = Share.new
    @goal = Goal.find(params[:goal_id])
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

  def create
    binding.pry
    @share = current_user.shares.build(share_params)
    if @share.save
      redirect_to share_path(@share.id)
    else
      render 'new'
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

private

  def share_params
    params.require(:share).permit(:category_id, :content).merge(goal_id: params[:goal_id])
  end


end
