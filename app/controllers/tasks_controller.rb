class TasksController < ApplicationController
  def index
    @tasks = Task.all
    if params[:sort_expired_at]
      @tasks = Task.all.order(expired_at: :desc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "タスクを作成しました！"
      redirect_to tasks_path
    else
      render :new
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "タスクを編集しました！"
      redirect_to tasks_path
    else 
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "タスクを削除しました！"
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:content, :title, :expired_at)
  end
end
