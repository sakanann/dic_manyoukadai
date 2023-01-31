class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks

    if params[:sort_expired_at]
      @tasks = @tasks.all.sort_expired_at.page(params[:page])
    elsif params[:sort_priority]
      @tasks = @tasks.all.sort_priority.page(params[:page])
    else
      @tasks = @tasks.all.default_sort.page(params[:page])
    end
    # @tasks = Task.all.default_sort.page(params[:page])
    # if params[:sort_expired_at]
    #   @tasks = Task.all.sort_expired_at.page(params[:page])
    # elsif params[:sort_priority]
    #   @tasks = Task.all.sort_priority.page(params[:page])
    # end

    #タイトルとステータス絞り込み
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = @tasks.scope_title(params[:task][:title])
        @tasks = @tasks.scope_status(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = @tasks.scope_title(params[:task][:title])
      elsif params[:task][:status].present?
        @tasks = @tasks.scope_status(params[:task][:status])
      elsif params[:task][:label_ids].present?
        @tasks = @tasks.scope_label(params[:task][:label_ids])
      # elsif params[:label_id].present?
      #   @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] })
      end
    end
  end


  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if @task.save
    # binding.pry
      flash[:notice] = "タスクを作成しました！"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
    labels = LabelTask.where(task_id: @task.id).pluck(:label_id)
    @labels = Label.find(labels)######################################1/31 01:16
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
    params.require(:task).permit(:content, :title, :expired_at, :status, :priority, { label_ids: [] })
  end
end
