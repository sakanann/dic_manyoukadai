class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :login_already, only: [:new]

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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def login_already
    if current_user
      flash[:notice]="ログイン中です"
      redirect_to user_path(current_user.id)
    end
  end
end