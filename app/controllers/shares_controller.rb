class SharesController < ApplicationController

  def index
    if params[:search_data] == nil
      @shares = Share.all
    else
      # word = params[:search]
      # @shares = Share.left_joins(:goal).where(goals: { ["content like?","%#{params[:search_word]}%"]})
      # binding.pry
      @shares = Share.left_joins(:goal, :clips).group(:id).order("count(*) desc")
      # @shares = Goal.joins(share: :clips).where("share.id IS NOT NULL").select('owners.*, cats.name')
      if !params[:search_word] == nil
        @shares = @shares.where(["goal.content like?","%#{params[:search_word]}%"])
      end
      if !params[:search_status] == nil
        @shares = @shares.where(["goal.status = ?", true])
      end
      if !params[:search_category] == nil
        @shares = @shares.where(["share.category_id = ?", params[:search_category]])
      end
      if !params[:search_sort] == nil
        @shares = @shares.group("clips.share_id").order('count_all DESC').count
      end
    end
  end

  def show
    @share = Share.find(params[:id])
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

  def new
    @share = Share.new
    @goal = Goal.find(params[:goal_id])
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

  def create
    @share = current_user.shares.build(share_params)
    @share.goal_id = params[:goal_id]
    if @share.save
      redirect_to share_path(@share.id)
    else
    @goal = Goal.find(params[:goal_id])
    @tasks_week = [
    @tasks_sun = Task.where(goal_id: @goal.id, sun: "1"),
    @tasks_mon = Task.where(goal_id: @goal.id, mon: "1"),
    @tasks_tue = Task.where(goal_id: @goal.id, tue: "1"),
    @tasks_wed = Task.where(goal_id: @goal.id, wed: "1"),
    @tasks_thu = Task.where(goal_id: @goal.id, thu: "1"),
    @tasks_fri = Task.where(goal_id: @goal.id, fri: "1"),
    @tasks_sat = Task.where(goal_id: @goal.id, sat: "1")
    ]
      render 'new'
    end

  end

  def edit
    @share = Share.find(params[:id])
    @tasks_week = [
    @tasks_sun = Task.where(goal_id: @share.goal_id, sun: "1"),
    @tasks_mon = Task.where(goal_id: @share.goal_id, mon: "1"),
    @tasks_tue = Task.where(goal_id: @share.goal_id, tue: "1"),
    @tasks_wed = Task.where(goal_id: @share.goal_id, wed: "1"),
    @tasks_thu = Task.where(goal_id: @share.goal_id, thu: "1"),
    @tasks_fri = Task.where(goal_id: @share.goal_id, fri: "1"),
    @tasks_sat = Task.where(goal_id: @share.goal_id, sat: "1")
    ]
  end

  def update
    @share = Share.find(params[:id])
    @tasks_week = [
    @tasks_sun = Task.where(goal_id: @share.goal_id, sun: "1"),
    @tasks_mon = Task.where(goal_id: @share.goal_id, mon: "1"),
    @tasks_tue = Task.where(goal_id: @share.goal_id, tue: "1"),
    @tasks_wed = Task.where(goal_id: @share.goal_id, wed: "1"),
    @tasks_thu = Task.where(goal_id: @share.goal_id, thu: "1"),
    @tasks_fri = Task.where(goal_id: @share.goal_id, fri: "1"),
    @tasks_sat = Task.where(goal_id: @share.goal_id, sat: "1")
    ]
    if @share.update(share_params)
      redirect_to share_path(@share.id)
    else
      render 'edit'
    end

  end

  def destroy
    @share=Share.find(params[:id])
    @share.destroy
    redirect_to shares_path
  end

private

  def share_params
    params.require(:share).permit(:category_id, :content)
  end


end
