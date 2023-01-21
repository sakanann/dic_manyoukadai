class TasksController < ApplicationController
  def index
    @tasks = Task.all.default_sort
    if params[:sort_expired_at]
      @tasks = Task.all.sort_expired_at
    elsif params[:sort_priority]
      @tasks = Task.all.sort_priority
    end

    #タイトルとステータス絞り込み
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = @tasks.scope_title(params[:task][:title])
        @tasks = @tasks.scope_status(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = @tasks.scope_title(params[:task][:title])
      elsif params[:task][:status].present? 
        @tasks = @tasks.scope_status(params[:task][:status])
      end
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
    params.require(:task).permit(:content, :title, :expired_at, :status, :priority)
  end
end
