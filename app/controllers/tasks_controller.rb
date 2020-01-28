class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      logger.debug "task: #{@task.attributes.inspect}"
      redirect_to @task, notice: "タスクを「#{@task.name}」登録しました"
    else
      render :new
    end
  end

  def update
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスクを「#{task.name}」を更新しました"
  end

  def destroy
    task.destroy
    redirect_to tasks_url, notice: "タスクを「#{task.name}」を削除しました"
  end

  # def task_logger
  #   @task_logger ||= Logger.new('log/task_log', 'dailys')
  # end
  #
  # task_logger.debug 'taskのログを出力'

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
