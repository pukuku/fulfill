class SharesController < ApplicationController
  before_action :user_info

  def index
    @shares = Share.all
  end

  def search
    # 検索条件がある場合は絞り込んでいく
    @category = params[:search_category]
    @word = params[:search_word]
    @status = params[:search_status]
    @sort = params[:search_sort]
    @shares = Share.joins(:goal)
    # カテゴリ選択
    if @category.present?
      @shares = @shares.where(category_id: @category)
    end
    # 達成済みのみ
    if @status.present? && @status == "complete"
      @shares = @shares.merge(Goal.share_status)
    end
    # 文字の部分一致
    if @word.present?
      @shares = @shares.merge(Goal.share_word(@word))
    end
    # クリップ順に並べ替え
    if @sort.present? && @sort == "popular"
    @shares = @shares.includes(:cliped_users).
      sort {|a,b|
        b.cliped_users.includes(:clips).size <=>
        a.cliped_users.includes(:clips).size
      }
    end
  end

  def show
    @share = Share.find(params[:id])
    @tasks_week = Task.tasks_week(@share.goal_id)
  end

  def new
    @share = Share.new
    @goal = Goal.find(params[:goal_id])
    @tasks_week = Task.tasks_week(@goal.id)
  end

  def create
    @share = current_user.shares.build(share_params)
    @share.goal_id = params[:goal_id]
    if @share.save
      flash[:notice] = "シェアしました"
      redirect_to share_path(@share.id)
    else
      @goal = Goal.find(params[:goal_id])
      @tasks_week = Task.tasks_week(@goal.id)
      render "new"
    end
  end

  def edit
    @share = Share.find(params[:id])
    user_check(@share.goal.user_id)
    @tasks_week = Task.tasks_week(@share.goal_id)
  end

  def update
    @share = Share.find(params[:id])
    user_check(@share.goal.user_id)
    @tasks_week = Task.tasks_week(@share.goal_id)
    if @share.update(share_params)
      flash[:notice] = "更新しました"
      redirect_to share_path(@share.id)
    else
      render "edit"
    end
  end

  def destroy
    share = Share.find(params[:id])
    user_check(share.goal.user_id)
    share.destroy
    flash[:notice] = "削除しました"
    redirect_to shares_path
  end

  private

  def share_params
    params.require(:share).permit(:category_id, :content)
  end
end
