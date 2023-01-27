class Admin::UsersController < ApplicationController
  skip_before_action :if_not_admin
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end



  def if_not_admin
    unless current_user.admin?
        flash[:notice] = "管理者以外はアクセスできません"
        redirect_to tasks_path
    end
  end
end