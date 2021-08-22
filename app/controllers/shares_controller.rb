class SharesController < ApplicationController
  before_action :user_info

  def index
    # 検索条件がある場合は絞り込んでいく
    @category = params[:search_category]
    @word = params[:search_word]
    @shares = Share.joins(:goal)
    # カテゴリ選択
    if params[:search_category].present?
      @shares = @shares.where(category_id: params[:search_category])
    end
    # 達成済みのみ
    if params[:search_status].present? && params[:search_status] == "1"
      @shares = @shares.merge(Goal.share_status)
    end
    # 文字の部分一致
    if params[:search_word].present?
      @shares = @shares.merge(Goal.share_word(params[:search_word]))
    end
    # クリップ順に並べ替え
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
    # アクセス権
    @correct_user = User.find(@share.goal.user_id)
    if @correct_user.id != current_user.id
      redirect_to goals_path
    end
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
    # アクセス権
    @correct_user = User.find(@share.goal.user_id)
    if @correct_user.id != current_user.id
      redirect_to goals_path
    end
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
    # アクセス権
    @correct_user = User.find(@share.goal.user_id)
    if @correct_user.id != current_user.id
      redirect_to goals_path
    end
    @share.destroy
    redirect_to shares_path
  end

private

  def share_params
    params.require(:share).permit(:category_id, :content)
  end

end
