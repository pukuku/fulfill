class ReportsController < ApplicationController

  def index
    @reports = Report.where(goal_id: params[:goal_id])
  end

  def new
  end

  def create
    @report = Report.new(report_params)
    @report.goal_id =params[:goal_id]
    @report.task_all = TaskWork.where(goal_id: @report.goal_id).count
    @report.task_progress = TaskWork.where(goal_id: @report.goal_id,status: true).count
    @report.fulness = 0
    if @report.save
      redirect_to complete_goal_report_path(@report.goal_id,@report.id)
    else
      @goal = Goal.find(@report.goal_id)
      @task_works = TaskWork.where(goal_id: @report.goal_id)
      render 'goals/show'
    end


  end

  def complete
    @report = Report.find(params[:id])
  end

  private

  def report_params
    params.require(:report).permit(:comment)
  end

end
