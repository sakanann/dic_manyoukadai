class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: :desc) 
    if params[:sort_expired_at]
      @tasks = @tasks.all.order(expired_at: :desc)
    end

    #タイトルとステータス絞り込み
    if params[:task].present?
      if params[:task][:status].present? && params[:task][:title].present?  
        @tasks = @tasks.where('title LIKE ?', "%#{params[:task][:title]}%")
        @tasks = @tasks.where(status: params[:task][:status])
        # タイトルのみで検索
      elsif params[:task][:title].present?
        @tasks = @tasks.where('title LIKE ?', "%#{params[:task][:title]}%")
        
        # ステータスのみで検索
      elsif params[:task][:status].present? 
        @tasks = @tasks.where(status: params[:task][:status])
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
    params.require(:task).permit(:content, :title, :expired_at, :status)
  end
end
