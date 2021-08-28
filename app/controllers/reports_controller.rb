class ReportsController < ApplicationController
  before_action :user_info

  def index
    @reports = Report.where(goal_id: params[:goal_id])
    # アクセス権
    @correct_user = User.find(@reports[0].goal.user_id)
    if @correct_user.id != current_user.id
      redirect_to goals_path
    end
  end

  def show
    @report = Report.find(params[:id])
  end

  def create
    @report = Report.new(report_params)
    @report.goal_id = params[:goal_id]
    @report.task_all = TaskWork.where(goal_id: @report.goal_id).count
    @report.task_progress = TaskWork.where(goal_id: @report.goal_id, status: true).count
    @report.fulness = 0
    @report.post_date = Time.now
    if @report.save
      flash[:notice] = "レポートを記入しました"
      redirect_to goal_reports_path(@report.goal_id)
    else
      @goal = Goal.find(@report.goal_id)
      @task_works = TaskWork.where(goal_id: @report.goal_id)
      render 'goals/show'
    end
  end

  def complete
    @report = Report.find(params[:id])
    # アクセス権
    @correct_user = User.find(@report.goal.user_id)
    if @correct_user.id != current_user.id
      redirect_to goals_path
    end
  end

  private

  def report_params
    params.require(:report).permit(:comment)
  end
end
