class TaskWorksController < ApplicationController

  def update
    @task_work = TaskWork.find(params[:id])
    if @task_work.status
      @task_work.status = false
    else
      @task_work.status = true
    end
    @task_work.save
    @task_works = TaskWork.where(goal_id: @task_work.goal_id)
  end
end
