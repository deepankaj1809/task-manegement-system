class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:update, :destroy]
  before_action :authorize_task!, only: [:update, :destroy]

  def index
    render json: current_user.tasks
  end

  def create
    task = current_user.tasks.create!(task_params)
    render json: task, status: :created
  end

  def update
    @task.update!(task_params)
    render json: @task
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def authorize_task!
    render json: { error: "Forbidden" }, status: :forbidden unless @task.user == current_user
  end

  def task_params
    params.require(:task).permit(:title)
  end
end
