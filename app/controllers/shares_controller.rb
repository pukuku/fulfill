class SharesController < ApplicationController

  def index
    @category = params[:search_category]
    @word = params[:search_word]
    # @shares = Share.select('shares.*', 'goals.*', 'count(clips.id) as clips_count').joins(:goal).joins(:clips).group('goals.id')
    @shares = Share.joins(:goal)
    if params[:search_category].present?
      @shares = @shares.where(category_id: params[:search_category])
    end
    if params[:search_status].present? && params[:search_status] == "1"
      @shares = @shares.merge(Goal.share_status)
    end
    if params[:search_word].present?
      @shares = @shares.merge(Goal.share_word(params[:search_word]))
    end
    if params[:search_sort].present? && params[:search_sort] == "1"
      @shares = @shares.left_joins(:clips).group("shares.id").order("count(*) desc")
    end
  end

  def show
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
